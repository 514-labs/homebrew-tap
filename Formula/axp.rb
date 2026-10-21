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
  version "0.5.1443-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1443-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "dbcad774fd53973f95b671ae38533b7ed46cbdf24e8c326656374e09ba0ca12b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1443-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "f6b407d8effb0b22e99ee1b93a191b76d06decee279837e15f997f6ee112f36a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1443-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "69b640b9abe925b8f430dab4f160a4b715600e859de2f02271081da332f95882"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1443-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "db95c03e6dfc28d7ac7ab88bbedb248de6b847fb5304ff493272ee49d1aeabf5"
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
