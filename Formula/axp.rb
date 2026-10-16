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
  version "0.5.1384-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1384-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "d21bef95927bab852217c61e5cb2d7cfefc2cb3469e020589fd8dd4fbb9793d7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1384-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "6c86f02c44457dddbb16e79cd681249c035c52dc672a6151b6e7a90d1678498a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1384-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "7bab369d5034837fe401a1258bc7ae21fb043e42f7e59c4c38fa0ed7f2020e57"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1384-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "49de21a0a7c115d00f3dbb92c5635a8f896ecf72ae3939df52a71966a14e6db1"
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
