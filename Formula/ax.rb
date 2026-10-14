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
  version "0.5.1346-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1346-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "190b41a0b70a1d16eee20d6c206d960c0f1231411ca27c6f6d214cb8cadc60c6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1346-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "feb925659ed363470f32de6d3b3a5781f051f389c30bdb37cad23bbfb5524e88"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1346-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "88e3db74ca33be3bd9344dad48e52bb9473fceee18e929545d3bf448e76ed3d7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1346-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b80963de9539633942d2385752c8774d3b1ed54484df0697f9c0d32814843c70"
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
