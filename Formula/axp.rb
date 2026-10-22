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
  version "0.5.1462-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1462-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "8bce2b2c924fe702d030e1d589b089053ae23aceac41e43cac7481e78e43a346"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1462-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "2899725d76b80caea1c344eed1428f78d841dbc2cc899bd3ec6da79180a80f2c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1462-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "a65744a83a32194e824a119384c8ee4d0ddd05a5b253fb77a19f0e2d7e2a6a2d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1462-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "5bcc8beb62782b0f7accbd5515283fe912cedf7a7b269122d7a559d06b64ac7d"
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
