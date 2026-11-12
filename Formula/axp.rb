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
  version "0.5.1728-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1728-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "91a4eca96c0e906d0c974e226a85df903662002f03b8a4e3246a5825afb0c17a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1728-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "919c29067ec22107ee690d6e4a29f66b34f31ec85e1968d02934d63fba3095b4"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1728-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f64a6b435f54838071396b2a97e9ea4d0b826baaba7031aa2c9473795a38cbe2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1728-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "49b0d403b96cc9f52000dd1dc8d22e0d527a9335f77ff02374bdb7b0e4368c03"
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
