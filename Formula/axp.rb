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
  version "0.5.943-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.943-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "80074a27f25f54308b5038decd62761faa8589d04c47552c8fb8c444fab7333c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.943-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "bf83b072208f45141a2867f5d4cbef5ed10e99060cea62b78a592ccfcbd725a7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.943-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "2ac0a1be56df32c7268290e4b53ab4ae9c8e6ac65364ff3561ec5e04e60b033a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.943-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "5688182ece39ad4b92478a2a6ac4ec39aac23c91ee53137e1dbaebcc2417be98"
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
