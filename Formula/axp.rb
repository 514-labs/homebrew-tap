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
  version "0.5.1456-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1456-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "bc1162d45c8d7c44a8943a1cb59bb665ae4cfe9bb57f71b115f68381cc3a2a6c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1456-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "d9c2a9c8d667950d732a710514045a53a22222e27b4073a75a401965cffd505a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1456-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "943986241cf2015c50c2f0d672974e66bcfc4eded42be1167e2ca745dce7c9ad"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1456-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "1f6a1255676aacd02d14ebc6124951043ff1ba580cace7eff8ea74c135e77ccf"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch archive
    # (`axp.tar.gz`), whose only member is the `axp` executable.
    bin.install "axp"
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
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/axp --version")
  end
end
