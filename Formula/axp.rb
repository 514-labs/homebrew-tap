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
  version "0.5.1357-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1357-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "0d6a85fa4d3a33edd01d341e444cc21c7799619117c1c463525fde1a26bf043c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1357-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "6acdfca413517e7b79ae289159bbeeef0e188f282a428c155465e6ea337bd6a9"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1357-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ce8e08b55ab03ef1716bdc69786a72375ab7e6f798f8f5429bae64a77b11bab3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1357-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "fe9ac498a31cbf04bf7cb86c049a41b362827a630e208aacaf8456aa1bfb2e77"
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
