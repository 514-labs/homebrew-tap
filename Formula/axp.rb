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
  version "0.5.1447-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1447-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "4538456f45462840bb539be384e019dea1581ad817bc029b852b62372f041daa"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1447-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "28dce10fa1f108b5f18070bb34244da04230f78f9202fd996cdbe7bbf99d8582"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1447-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "99b7d7fa521eae017ef1473b79fea57cc37ded4876edf05b44997b427f97b8b5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1447-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "aa4fd670c44b5f84409ad1ef49c31aff91a1d246ff02a19f82775ee4a10c5d66"
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
