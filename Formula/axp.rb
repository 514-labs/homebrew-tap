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
  version "0.5.1791-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1791-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "5abee0e7c58a091cbf9d67e597732791c4706a9472d9509eb5d61ad5eb77e79a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1791-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "a959aa038dc4162137bb424efd6b692187f57a929ff161b46e0e2396c624349f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1791-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "273d83fce6451f46e7f081b81bd3cf19f075c0ce2c523f786b6667376a15f049"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1791-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "9e545177143e4436c095dc6340a69c82d199c1ddae79e5d508d0d7a22e626d16"
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
