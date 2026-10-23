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
  version "0.5.1479-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1479-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "7efc118917dcc902fa17a1206a3a832d67479584e3c5ad804aea5f9628cca115"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1479-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "e1c52bd1595c4daaf5a3cbf091bf29dd4df6e8c79a9fee662eb1115a587ea7d8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1479-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "2ba2dd5a4ec3cf94cf9cee39d4dad154fd2791961987340418314ac87c2b2a40"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1479-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f5aee2df62a16fff53af0a83175ebbca9aeeee77e24fc0c7794bd5dcbc24d09a"
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
