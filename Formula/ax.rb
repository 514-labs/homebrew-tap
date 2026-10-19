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
  version "0.5.1427-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1427-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "9bc4e424a93873f90359386e56349bfadde9cf3eff09a359217de3275dfcaca6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1427-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "21653a52c4804634137c648cacc9717f27b7a65ca7526787eea5512dca768c6f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1427-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a01f5b28078f11d9ef0dc7d95c7a1471aa8a5a4d7a86e075ca31c43cb9bc5e56"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1427-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3cdec7c2b75e8b43f13b34aa0399ec6bc46ceaec4d04d728280d39078a30cfdb"
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
