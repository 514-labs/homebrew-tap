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
  version "0.5.1798-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1798-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "f99636d50e6b93779d6ddabd9e47f952d229f37a3f12aba26545940a748ec2f9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1798-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "2bb0b1d89780c081a2e106c0bf3083dd7c0ab77f4fea73dad94001ed2746f4dc"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1798-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "cfca9546d58c171ee13c43ff4aec49134e87dd2f5283a400fff593e8133263d0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1798-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "54c6e3111c52fd0e572bcb77306b2031c1050f6aff88c7d7a1c37101af96c02f"
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
