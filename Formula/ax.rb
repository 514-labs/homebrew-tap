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
  version "0.5.1684-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1684-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "e3bc0f1f4334c75ced6781daf0080a479d19d572f3ac9db5c3d8bc1f649f8967"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1684-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "ae7e9ddd59f52f3da390e49fc2e0fc7b94910a9860c3c8bbfa46ae7b368ffc94"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1684-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3844668ce0695878332bc06051aa9aa725b8eb226507df708998d795248c1e4d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1684-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "21160ea608f56e4ad93c291a4db8d888ea5e60e26a94ddc5f9a573a88f9fb3a3"
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
