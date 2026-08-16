# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `axp` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
#
# ENG-3612 deprecation window: `axp` is the old name for the `ax` CLI. This
# installs a byte-identical binary that prints a deprecation warning on every
# invocation; switch to `brew install 514-labs/tap/ax`.
class Axp < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.804-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.804-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "cf1536019f9c82ec9e165ff65a3934dd4362a02ccd300ac28e67dacfc8f414b9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.804-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "d64817bb3ef8cc90f1efb967c8ce9a44a31f6ea37606c20ba0ebb67d66024c44"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.804-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "42ae3f3611a1e88e68a151ed0811d5034355847055d71ad2cff4f4a80dac432a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.804-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "be385c62871165742092ab8dd4a732c0ae1c1939cf20ce8b2cb5295a07e3f04d"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch relocatable archive
    # (`axp.tar.gz` = `axp` + libduckdb sidecar). Install the
    # members into libexec so they stay adjacent for $ORIGIN / @loader_path,
    # then symlink the executable onto PATH.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"axp"
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
    # Keep the smoke test hermetic — `axp --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    # Clear loader path vars so the test exercises the archive's rpath
    # ($ORIGIN / @loader_path) rather than a host LD_LIBRARY_PATH.
    ENV.delete("LD_LIBRARY_PATH")
    ENV.delete("DYLD_LIBRARY_PATH")
    ENV.delete("DYLD_FALLBACK_LIBRARY_PATH")
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/axp --version")
  end
end
