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
  version "0.5.1710-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1710-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "86c285c1ccb2c0fdd0faf62cb1d1115caf510cf7cefef608dc45ed360684fea2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1710-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "0c63b4f8d1a6538d139bf720c2851e8fef83e8bf7d841885b6c0601d4a71d727"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1710-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "60c58c15518d08068ad4e843c5acf43802bf50fab7940a55f5ca5311b8303eb9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1710-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "bd0e13d68bcaf5b17907ac89b12538e1e5bc2e25ad5b21d846adb48af3e2f24e"
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
