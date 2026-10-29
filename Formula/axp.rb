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
  version "0.5.1537-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1537-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "18c48b1fec1937a19d07578e8066ac6f2f01154ed9862ebe8b059aa5bc2efcc5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1537-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "30fb99d288162c559a96e0f0cc28e212a689dbdb09ab45ab8d73b5eda79c5b05"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1537-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "0ede9ecc9c7a07c45d6bf50faa2f23da72801b611c58ece00d473e8281b5b5dc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1537-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "485b1b30b80a7f47823680062898b04dc037e83a20bc9964f355a511cc39c173"
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
