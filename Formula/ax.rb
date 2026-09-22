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
  version "0.5.1083-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1083-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "97a9189bb4c7b6127ce6b347cb7d52d11784c2ccfd8f7f62f9007d50c1a0951f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1083-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "e8330c11f162d5a5a4c8e51f293e102ae1985f184a4a3a28d6b2152b59b8c8ca"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1083-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "be1676bf6e77101d2ac8013810ad18c2ce0393d92fa03ec673a9d9a2f39918b0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1083-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4b5a9f14629f4e8e61f2b88120b1950dd59e2de00093b5e222958e2a9493dccd"
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
