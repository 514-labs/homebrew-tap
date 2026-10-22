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
  version "0.5.1462-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1462-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "ec27e4457f0b0346f7b8a0ae3a252e18e9dd8dca1fdc6fccc2a070677d9248b5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1462-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "9a20600c882494816de604883f4140972d656063d01682eec995ca2cb76c78e8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1462-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6549c64676c888d5b3fc1237b8857509b85355248dd85634001addd8a1844ce9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1462-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "bfa171101375455c0114fff7f8ceb8b286b92128f3262a3bc47dc7ca1c07ab49"
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
