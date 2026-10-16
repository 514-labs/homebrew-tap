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
  version "0.5.1395-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1395-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "e37450176213e4805d243690bc4e107399481b5feb3c552a661ed0b4f55ebb59"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1395-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "635d6e5a18974a40c138c17dfdf73fcb4193ea17d7910ab545ab3a8f0804ea17"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1395-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c8032ee96db0868015b15e84f1879f9a9bd64ab29f1d8c706c499e3062e2c289"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1395-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "21061273ff4c197a513169cd3deeece6bc49b066d43e69d0899d4e697ab8c755"
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
