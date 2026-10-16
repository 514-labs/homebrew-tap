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
  version "0.5.1385-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1385-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "c737321881f32eb6151c0a7e3e84ff1d6f6e01e40878ce61cdca788ba7a544ae"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1385-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "997174b446eb44b021f7a05a95c78c9a14d896130935d387da46028b53c822ad"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1385-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "8e0b04fe1cf89b3ae0b603bb93198ed8b208d588d60365dd615ac1afac863eaf"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1385-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "91d62533311814cfeab55a2bf465768c5d28a6232c6dc99114fd9ac06b3d5333"
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
