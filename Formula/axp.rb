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
  version "0.5.1523-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1523-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "d10e5e2353e994fa28714425896f908126da0bc1bd777b5e4fc7e5141719a5d9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1523-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "bc7ca61dab6c09b832047e2ef35dfa9b396e9b5fbe5932d3ee4ca10c2a788345"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1523-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "7e1bfa07af22887b47ccd919a945696fd2eb901d27641371992056c649c369df"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1523-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "808267be3975e2530ea2e69803f55cbb56de2f16826986fa85d5657e9106210a"
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
