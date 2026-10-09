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
  version "0.5.1294-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1294-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "f39eee30324089aa1d8111e549d44a3c123da986f96ae2a9924a13e91d2452ea"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1294-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "779a0a19748455a37e0ff60b6bd3875abf69d75594197394bfb5d47178abc447"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1294-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "993af6e698be7119cedceca5cd94543ffe06a6085c9e637e73e9fb386fdac432"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1294-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b1a8f4f7e713cdbaf94aa8d77aeb050939d349aad405f9f902198c69299b8e3b"
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
