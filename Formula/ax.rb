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
  version "0.5.1790-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1790-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "d8c90479336b3d829c9840e5417b7ba03bbba9c4e0e98466317652fd1dced6f0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1790-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "b6a807d99c09532c45a00e3616534947d1c51bbd38150e8d2c056c42ce96164f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1790-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "aff270ebdfce0f5c0a2e2652041cf868b20061bffa4a2dc64362b3485878632d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1790-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b27ee2aeccb3ed783f2e37ccee9671493dd2786f6c031e47f294b869e1fef615"
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
