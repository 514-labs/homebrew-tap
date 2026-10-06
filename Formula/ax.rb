# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `ax` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
class Ax < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.1255-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1255-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "156759f5a30cf872d6b5891bfd0697a11c870093d2b73a978d8fcae6ff398d95"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1255-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "b8c432644a549bc7ab6f1c559b297ced231ccfa0befe8b0ffc9d0581c9a1ac4b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1255-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4118c042d6c800c6bad1379a70d6fd96583846aa8ab9249202fc281936fd9810"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1255-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b2c667adc212feeaa4f93bcb9baba479caf70bb2d4ac4460323f7edd481d3d99"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch archive
    # (`ax.tar.gz`), whose only member is the `ax` executable.
    bin.install "ax"
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
    # Keep the smoke test hermetic — `ax --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/ax --version")
  end
end
