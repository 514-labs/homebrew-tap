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
  version "0.5.1679-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1679-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "d4f631bae3c2b7cb617b09c727e45ee9bf466c54dd04c048a7ef284910d27373"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1679-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "ce1e2f28c33f1be41cb62441210fd6e19528a010b30462094667e4c68795b58c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1679-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "99fec0bf8ceeb09edde9a72c810656cfcc4d6d35965df5cf63934022e2e92cd0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1679-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8bf7cbdbe787fd053b3e2f823b9e40f5eecfc11cfb8f9481cb3f340c25ed9365"
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
