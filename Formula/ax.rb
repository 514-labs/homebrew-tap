# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `ax` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
class Ax < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.686-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.686-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "58be640f3904f60f1b6f1d4490227ac1efc78dddda466cdaa07f4a282af7f38b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.686-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "bb7bb5579dcb092f76a621ceabf68484d021fd62475b937158f195778a525f1f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.686-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b84446851b0816e23c448c47e4f3cbaa7d980c2160b8d61bddf50d963b795c27"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.686-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "12e3dcbb2534aaebb02d7d9b1a79059e31a1b9e4b6a27a6233f04b516e8a69f9"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch relocatable archive
    # (`ax.tar.gz` = `ax` + libduckdb sidecar). Install the
    # members into libexec so they stay adjacent for $ORIGIN / @loader_path,
    # then symlink the executable onto PATH.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"ax"
  end

  def caveats
    <<~EOS
      Sign in:
          https://app.514.ax/sign-in
          ax auth login --token <token>
      Then get oriented:
          ax auth status

      Next: create your first experiment
          ax experiment create my-first-experiment --template cli-install   # see --help for the required flags

      Learn how to use ax: `ax learn`
      Already have experiments? `ax experiment list`
    EOS
  end

  test do
    # Keep the smoke test hermetic — `ax --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    # Clear loader path vars so the test exercises the archive's rpath
    # ($ORIGIN / @loader_path) rather than a host LD_LIBRARY_PATH.
    ENV.delete("LD_LIBRARY_PATH")
    ENV.delete("DYLD_LIBRARY_PATH")
    ENV.delete("DYLD_FALLBACK_LIBRARY_PATH")
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/ax --version")
  end
end
