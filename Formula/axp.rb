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
  version "0.5.1227-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1227-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "2a292776cff6683945dd81fe65df7940591b682cc5406d9215ff65a0d44454ea"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1227-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "b80b64a75e3bf546677c0677c388ae065398d55e0cb47d94597de0c6c4de019c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1227-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b4f7dc930294131375719cd521ea29f9dd354952864ab3700a2330331635d761"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1227-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "2a92dc2305adf72f1a2c33a5b21be902a194b740ed145167c75379e02a964314"
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
