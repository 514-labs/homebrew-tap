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
  version "0.5.1539-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1539-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "53d75991f7c2e4837a967909087eceb5aa1a4edee1597f4bbfae6e32953f38a8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1539-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "cba0c5059f8cd632933e6557de2d8c3ab078b721a1db33e07785d5ef3873a740"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1539-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "bd5049275d841033dbdf058d3f91965afe73f1890815f4df1769a82b39491005"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1539-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4a5380771b5faa8ea616ed07100a5cf34b2d56fc7b6671fb3caeb83962051497"
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
