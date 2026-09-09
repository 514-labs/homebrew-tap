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
  version "0.5.975-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.975-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "aa672675f9c9010730c5763df7e168429920b79653654638ef19bc0465bc6012"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.975-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "8854d07811e64e910033d81d862a0c8f218b2862c3bdc9de5fbe98e40693c179"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.975-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "da0b487394be8dcc4428292e3bf837308041969e440e791d37091a7cf3ff6b3c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.975-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "6b9dbebeed57ad0cf6cd0e09b52dd3886dcac6a8216c49f2500b43cccf8aa217"
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
