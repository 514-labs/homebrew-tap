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
  version "0.5.1289-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1289-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "3af47e5322d41780c7d1fca4da900cfd2a983dffbac7819cdcdd73fad4cffa06"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1289-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "44d2e98bd423809fb21e6f6afa6938d18c44b9ccca0d2ce043971904608233b7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1289-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e1642ceec80bdabcfa38d916629dd2533a3f724d2f54e2711b83423ceea1ca7f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1289-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2684cc1a48acbcbefcc9fc4890d54fc1b60dc0bac13c4444ce10c042de54d67a"
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
