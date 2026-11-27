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
  version "0.5.1800-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1800-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "3a5b6b3d47c2463e5e48b76e9e000b2b9f5b61606cf19a226538541058a51d15"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1800-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "48664d9c2328a78828f15543da07d7e62b5df015b7b438c080f8cc3ccc579e27"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1800-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "a9c655fd3848be41b442fbb1b2a673fb5d1e73ed26f22cf8a189ea4b2f48d61e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1800-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "4aaecdd5965a0b02b829c99c42b6157aed699f916ef835808b374fecc6799020"
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
