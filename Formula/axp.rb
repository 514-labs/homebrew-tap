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
  version "0.5.1625-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1625-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "c0a3bc7c91747ba8513854722168dd5b8158d41bd6300d41d3c034bddd366334"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1625-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "06f252a5c93eb080b3aeac4d738b9470b43a379142dfa459cd05abb2bcd53535"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1625-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "9044285b97464ca902c355effbfb7313ae535db7c9dc3320abfcbe05815e0ab8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1625-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "7a952ff7226d9e41b54b028b34dcc690ea996c84c50287900ae5e03c8c6cacc4"
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
