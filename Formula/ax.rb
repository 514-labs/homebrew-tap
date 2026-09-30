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
  version "0.5.1208-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1208-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "6f10bf7f455c1a2ac171a2796bcd657102d685c5288e049e8cf9a8a05de83d9f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1208-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "ffcecf7ce9479a499dd2e87d52b08748e88508b5d4a828091ab02837143f914b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1208-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5ca25091c20350a6a66dc93e43f2190fc63dfbfca54e09d4449654dfaa9d3e4f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1208-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8db2ef7e7e84abae732e71e8cf9b13db30d08040f027a8a2e3d2871ef2e3a24f"
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
