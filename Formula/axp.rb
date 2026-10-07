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
  version "0.5.1262-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1262-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "4ccfac83a7396d13c07d6f4b28f88b1e5226b4f88fa755c44902f0d187b24eb0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1262-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "56e7c0d0ebdfbd74f8f2ceb981193cfcb7f41c45539e7894fdd20c8e367c80a4"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1262-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "e3ec309d642b1deb582d79f76b5fa8c343c6dbd7df4aa1decf81a21827a07dcb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1262-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "10b06d097d3089b16bc1f36f49a6fdb724b0b5f754ae8dbb338f3442b988f23b"
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
