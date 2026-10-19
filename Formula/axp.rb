# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `axp` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
#
# ENG-3612 deprecation window: `axp` is the old name for the `ax` CLI. This
# installs a byte-identical binary that prints a deprecation warning on every
# invocation; switch to `brew install 514-labs/tap/ax`.
class Axp < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.1422-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1422-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "fe1a7ee73e476032917efaf4065fe807896ae727628e72f39a710221351f56bc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1422-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "ffdfd64944c9d03c7ab81d02db95b7aa2333b4a4b4ce6b384700eadcf4827a21"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1422-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "9cc92f089b6f9e31c52badd661520be9253b7c1fef5c82dd8fb96b053bb23f25"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1422-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "25553086fb1300584e3830e4a600d3b64ec2d23e53d32d3540337b89f4a79261"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch archive
    # (`axp.tar.gz`), whose only member is the `axp` executable.
    bin.install "axp"
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
    # Keep the smoke test hermetic — `axp --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/axp --version")
  end
end
