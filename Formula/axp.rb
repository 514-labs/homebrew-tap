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
  version "0.5.1757-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1757-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "ad745b42e1ed78c86528e72b931f86e59d41f6da347922ef8a3fe356e6f7eed6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1757-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "2c8310d675a08e008b0cb310327dad337bf991967613599c09c1f73120d31a2c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1757-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ca68832bd45b09582fe00ec1c761fd005df11c600bcb300edbb72e9bac42e50d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1757-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "0b0b20469bd778abd915c493145681f61094476bd6cd23c222854fda24bdb6e2"
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
