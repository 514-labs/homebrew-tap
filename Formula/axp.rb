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
  version "0.5.1404-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1404-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "9558ac9a3fb46e0f6bdd4e31f6aa986103e409a9e2021af89633f4dc5f3f943e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1404-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "565792f0cdb5e5662deeac006098b00d5b4286bfb4f55a7734033b3ccd89ee45"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1404-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "6a9c4f9585e2d67282b169a3ac0940af93af90e68705f971e739df446d645c10"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1404-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "573fe8ed813bec7e40d9c77fdf549d30a334f14d3b16f1852b0f472b982609fd"
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
