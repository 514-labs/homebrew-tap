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
  version "0.5.1451-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1451-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "ba993c345f596aa4d8912041669b1590fc37859d05948ef312e410fbc349a76f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1451-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "0c53034c2efe31315c71dd4b0533f41c6c700fe1bd9227ef1aca708bf978e885"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1451-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "a2893ab907332ca5558b96f61ba6733c612bb149518adf4a3567c045c66dd289"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1451-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "9be880221e88f47026db4a558b24fc6772285e78a0787cc59d9920c4457c8275"
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
