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
  version "0.5.1719-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1719-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "dc84f526c640547524deec1576912ddaf39dfeb7d4f167dea59932801a52a9d2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1719-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "bf7c9e78544755db758c4af5bb76730ba8ca7803ad79d4b830ea22ed5585fa61"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1719-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "04dc72a118c04dbb897886a09d222159d1de8809db8d5268817fc5751320f31a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1719-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "608b71b1fac8483e81da1462e29de67c2af87ee29d1d7570bafed46e3b88b8a2"
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
