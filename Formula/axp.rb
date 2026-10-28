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
  version "0.5.1530-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1530-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "73fd1840904919a23ae47bb9662d45fc179549f42f3e202347f1540541596ab3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1530-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "2de27570ea121bb8af18f6e8b9ae6fab46fcc1230e38941be23e5af5c7803ab2"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1530-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "58392fcac7aa33c3fe1f62c6a73a058647c8db593617188f18a64727281db54b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1530-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "a57fa0b3a8bc157cac6651d963f3c96a275ef62e5b04e5d85e8feb69d85f037a"
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
