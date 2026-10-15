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
  version "0.5.1372-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1372-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "af46f94aa7dfbb6af7dff184f5a36fe737aaf528757614252c9afb06faf29dde"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1372-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "0121669919a70dcee53634fe91efe3cead93aef361612a01b859b19b6c58313e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1372-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "08a9293b683512dbd9e90f5770cf497c20657c69d9aca03ae6a376fe3773c5f6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1372-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "bbbf27d5d5cdb02e8ac37644cc039dee53d2e7278d45e498ab35ec8422ff4178"
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
