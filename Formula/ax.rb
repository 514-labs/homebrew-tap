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
  version "0.5.1642-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1642-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "1ab20f4a803bf48daf0e623595f700e9b316f97289a54037a1d32f621c9f0543"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1642-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "0ec93d2bbc4dc623cc97196c7d0a0ba1e268ee8d343565b8cae67af507497101"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1642-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c1638b2f01a0fb81a559f8d5e770ba2aeedb28e0f1dc1d5d8a543dfde3344916"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1642-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0ecbceb01382a080834c89ee40a8fa85fc5028133692c2af49ae6bd05e5cf6f2"
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
