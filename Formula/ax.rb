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
  version "0.5.1494-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1494-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "99cc28d8022a895ee2349a466b8ea131110fb2569691b586289170a22799770e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1494-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a3a50fa53e8520d0d35c5a7d6b86c53e1be3705f00fe057dd1c5156bad9ba3e7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1494-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "79a3393865d977c3fd0c085956d3a84469c8452b16cad42902dea78c680cd643"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1494-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "101822ade1082bba4bb57fb4effb75a8c51da11a746b7db14fb03c03e12c53c7"
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
