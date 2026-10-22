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
  version "0.5.1449-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1449-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "d69668b6c0ef7a4d0f7e07957f77fc706bb75df4d44833f5d34cb105d4c2179d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1449-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "75ddd3041a023fd9f10538b8dde480fd85646dd128a94868c91408e0e36a68b9"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1449-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "05cbd9fdb6518f017f68db87c21666302ff5b938ed276ac3438752bd537a8d07"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1449-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "4d3222fa3863886e4ef0330f81f542f97e816e65064fd19ed32a42033a92af93"
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
