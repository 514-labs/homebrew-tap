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
  version "0.5.1685-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1685-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "19c808e5132dbf6937f606eecac4960c079ff0aa6c4c9628432f4a2d5eca8ec4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1685-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "188705b0c37b2d143e88a1233713bd5d36a57d62f4af136f7516e4173f81b666"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1685-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "5474091aa20ad23717405a8fe85d9e5bb3d8c521de4786af039abd38ee760463"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1685-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "1bce47dbfaf303c0ea96d0677927ca927cf02b0205411f5faedef11244626058"
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
