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
  version "0.5.1774-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1774-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "5bfb386500a3ba066c836f8818469f2acbf80c51026b259dac15004fd6e840f5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1774-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "88a20263f7636fda25407b7d6fcf9f724a3a13d72cd49134e8e9d053b742aa57"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1774-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "5614a95d8fd5591af38c1aede80d847e0131d4dfd417e0fd0495c23e2555771a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1774-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "1dd900688526b456803db5bc12b3a09a43fc63c72e5699436b53850d7d9b2d0c"
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
