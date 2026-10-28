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
  version "0.5.1527-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1527-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "b5b7c5a8644f5b8c79940ed3c3f3211f25469a6840ffc6c9d50639fbebf14d05"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1527-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "d80594e0307903b8cb18dc3dda6f12768509fd3744ff0f4ac19443f5e5adfee7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1527-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4c96e7286810f4bc579c819fb12ee9289e195587e905f27b5f93921307a1f2ff"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1527-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a69b3b765ec687662a8a243f06a31f71b687a6a727e1f4e2b87db824f8918a2e"
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
