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
  version "0.5.1717-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1717-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "48bfb90298296cca83276451419561c5357eb9bae9c8c35980d2df0ff4e6717c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1717-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a8b5e38c6bc5e759feff1a069db393a3dfece7ac461176f2f54de46408aa2b63"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1717-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "096ac7a69c73a0da83a79b3a0d97b1a74672f974035a3cf7378868e6b0f0bcdc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1717-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "67a709b1d9c541a3c803dcc376961364ac43f5039054fffab40530c45f0e17cc"
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
