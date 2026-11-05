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
  version "0.5.1649-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1649-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "145fef8210524b38571597b7441fdba07f7d24ba61a71ffb3e31cc7e649c0ebc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1649-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "52074b0b74454775d94a18fcf3b7a0b40f1dd16b7638de7ff8849801e6d4e3b2"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1649-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b0b104fd6861e0791fd51583e47e14c68013ab35c5699bd89589948d0350926e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1649-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f645936bf1a88e6568693a51b1af26cc533b3aa164dc025eaf6dbafb5f25647e"
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
