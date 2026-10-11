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
  version "0.5.1318-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1318-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "d8139f717d05a3f567e73dea7d0066318ae668b2b7ddd1fc974592e759db3df6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1318-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "1b74589b78e31c48e5d822bc093d75ebbab748d46de4b81e570b91f688c3bb4c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1318-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "9d1e654cc16c3a04abee2c9f8116e0b8a9bcba6c4d64433109d34dce630ea00e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1318-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "8eb04efbe560851b5d6a4214424b1967d3e121a1531a9ebd68025c628b91f480"
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
