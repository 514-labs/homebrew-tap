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
  version "0.5.1441-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1441-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "370b153cc2a841b2c4e1939101f2e4fdbabc0137a7f739a91dfc229af2fbba71"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1441-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "bf023c7b89c72597613fed90400a6eef8970686a1c843d91e7644418922da25c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1441-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "92d83a8f0ee87550a2a2569b7a963ef195927762dcb272dcf13ca8711a111765"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1441-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "cd760169f7843f4b221dde62ade21de2cacb78b7c3a44ad293da44ee6326b7e2"
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
