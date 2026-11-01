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
  version "0.5.1625-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1625-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "e0a9b327db7d5a5d5eeeec0dc4b75013a98d76c8525b01583d555327640f5348"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1625-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "274a9c10472d493b7c36b7a23513b4443c21828dc17ab0b71cf3f1f548dbf0ca"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1625-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "318ee53f2d726aefef01f9c4df0a2de88445b9432dab94d708e0bfb66aa3b4f2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1625-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "97185f111ebdc4851ac31848f8895597569e9fb8756e0368452ec439b34678ee"
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
