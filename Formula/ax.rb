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
  version "0.5.1383-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1383-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "e2b4cd3d41799adbc811aba996540c13dc0b78a67d7b77696a25503b6577e115"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1383-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "ed521797b9a56ec001254934b6c23924e7435c93c6ff0da0b9943b96c7ca9215"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1383-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1aa86d0d50126bda350c85ab191ab6561b5fb402a852e597f1b496854d548171"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1383-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "33dd3e17b846ae9aac8073fbaa3d5cb4c32a507d62e8ede4e5e33381c95523e0"
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
