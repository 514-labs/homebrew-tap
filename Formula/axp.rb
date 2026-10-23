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
  version "0.5.1477-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1477-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "5e64f01e0701bcc31e2ca345cce5b6f1bc69fdc336f00994db882c0619558f65"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1477-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "2f707591ef27a3b044746814a9abf21058b47e8595d294d043abeaad2633fff8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1477-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b5526a4410e10d089428562db918c98c9c4cdf717b1916cb5b835374d762942f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1477-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "2fec2e1800aaf01c57e6c36520249c1b7f8b0a3b96fa5dcf5062505b659f5652"
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
