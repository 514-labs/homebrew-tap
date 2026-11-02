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
  version "0.5.1628-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1628-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "5005a5fecdd2a5dd6d2814d19b0be4fcd9a5fde8cb6feba0fe7e6f6fe541a39d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1628-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "c9c10a8b96a0eada4fcfe999f8bf2603a95e44a7d80705bae2012861b7577abb"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1628-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "94b066a46e51699275c9cab9236b77c34881161432bec0ebf7feff8397c12cb3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1628-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "26d5993a4f5647f4925d27540241921ba33c306b1036088c36a32a6783c93a0f"
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
