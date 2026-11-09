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
  version "0.5.1694-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1694-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "fabbacde348b68fbea2fc058b6477c3e9b9b2f8eae0a690a6378456a36e42266"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1694-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "d3574654d823a3926cadffd603d63fb74b40259da080c9a3d9cbb6107baec54d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1694-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "8498633f69a08219aea8180422de251d8078cb49cec1570389cdb3968b87f4f7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1694-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "a8686a5b673ac9db81b3f7bbc09cff7efe165da9583afa2babb8af4af84defbe"
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
