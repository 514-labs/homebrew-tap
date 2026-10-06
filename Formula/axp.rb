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
  version "0.5.1252-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1252-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "37b088b973f054409c9515b3b48850fe985e1b97a54a7fb38e81ee3926dbd238"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1252-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "e12524ca1897ae435703778c751c2a8d000d94e1ae7de6113331e88cb1f32dd2"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1252-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "3273b0b22cd4484836097df3a7bca8f0e3b4e2e2e2662a1718df9b1f8f2df965"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1252-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "6cda0485d881d89eafc82dc153cb7890695dd94513f863fdc5d69e6d44d92b8f"
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
