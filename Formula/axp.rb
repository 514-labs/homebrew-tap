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
  version "0.5.1548-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1548-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "3e61df6b0918f4151feb01667a51a085d66ebb948c9e800307578293abbcd800"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1548-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "2a29a1805ca5e042bec6592cca57d14e4fa6c5e8c145e17ab4462bc3f527baae"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1548-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "2074845e7697ab272afacc6ac5b30ac079f23ecc9b609d2b50af5634c5931db5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1548-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "4b74b66525219af0ffa5c657f621654fd259fd9d12ed6d688279e64181512df6"
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
