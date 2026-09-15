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
  version "0.5.1047-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1047-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "7c21d60393c86b52149abd575dbd59d2882200bd1cfa41de9e4fb516de2d9849"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1047-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "406d4d1666a35a4758b7d9bc869a8b2b3da6f141badb53b310927b360b20d45b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1047-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a89fc8c770fbc0246e95c82cbc848d4e22848d569aebe0bfa59b0774060f4ac6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1047-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ddf40282ea9265c462524c5631e9bc20ec9d8a3d5fde2ccda50b1ab53a0086b3"
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
