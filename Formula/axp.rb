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
  version "0.5.1287-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1287-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "000f7b515d044847ed019e989c2bea69964a0e70e23c7cbed2cb060c9896a35f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1287-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "9ea2518a9501d3b6ddfd0613090a729179a62b13d797325474fb139d670ed5f6"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1287-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "94993b1ecbeadd26ee5293ac9369f3aca2a714081dd44ca6531bb0e8f8b2fa6d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1287-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "af582d6a59cafa96d9e03c0b225e9fb0228493f04814413073710dc8bb8b586e"
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
