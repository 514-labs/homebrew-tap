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
  version "0.5.1783-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1783-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "382a7a2e2e3de8f9c909cdf42fc1e8f3b81c7aade79481512d385061198e8bcf"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1783-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "6c1f65d78933362fa1a350a17f7475866183af65c4ca3ee9f9b41dd3d1dd2723"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1783-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6ed19a69e2b43b7e4eb85e1d36fc4689747346758a09632dc2e8dd57cec2eaa7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1783-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "22df46fd8ff6b84c65d7e11c0cc3e7fbe96b3bb5ac0aa3c8028eaac5ba156282"
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
