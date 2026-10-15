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
  version "0.5.1370-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1370-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "035e98e91a11fb9e793deba4db9c95720fb5bc7e60a4d7b9eedcb316b70d853b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1370-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "ed038f8edccef27b4dc6f6b5783e77e4a47fec00318e65ecbd438e98b104817a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1370-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "1195a602d93a6c5b93466878164a8de4418e5c84c3aa0b36f9ed6195bcc9698b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1370-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "88362047eb96a136696b7e5b82812f26b58efd983414769502f76f354edccfdd"
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
