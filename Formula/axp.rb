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
  version "0.5.1330-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1330-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "08c385f412dcb724927841500932047e32bc7dd16928317984d87846de9e72b9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1330-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "d26f67dd80a8755c0661805805db013c05ba90b18f4f51dd3f9448eb0705c6a8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1330-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "bb5d7bb3a9b22d57576a20a34f9df962fbfb80baf3f563142aa19d9b3e5ac319"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1330-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "969a54eda02fec4481757dc924ad857d426d1cc790238c2c4a6aef58f90a8ec9"
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
