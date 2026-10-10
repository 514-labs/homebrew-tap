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
  version "0.5.1314-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1314-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "cbb6fcf3791985ec309bf861e67c912dfe2082088d10731dbf3f9c62156af76e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1314-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "acb106e192c8cd9b0ec91f7071c5d08e8c2ced2930a5ba6b2c5703c3a479376d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1314-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "8ae21c30a2cd586905fc47554a1aa2465e18204a931696792e03e560053d13d4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1314-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "49d2ac24dd27ca8274cfc6eddcc208b6ba84aede398d9f86f12718c315e81098"
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
