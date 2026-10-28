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
  version "0.5.1508-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1508-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "2c13a4f72d315bb54aecfb9c56a8c55287ce115ba04149992371301b7339b24e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1508-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "c293b36b70d73444c564bad443e574ca435ac46c85926b7e234514759ef6c1d9"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1508-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b2ecd7bff862429b70ae59ad5dbc6e30ca466c358d956ddbbbd73ddbe5beb5d7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1508-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d386c594096f754c5d376571c78a322c7012395172ff6f1bdffd0aeb4bd7f892"
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
