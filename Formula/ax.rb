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
  version "0.5.1319-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1319-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "d2f260993fa47f93fc10cdcf06bebc2ae908f467e7944e5b87bcee06db858fa0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1319-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "af49520b899a8f6537bec41092c6e027a54938fa4e90d21292057a15d67b3552"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1319-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ed84fde44c35db206afe94829deae1bdac9f6913ade429e1125a6f7e85244eac"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1319-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "968834b2d6caa1dd62a6ad3d2d533c9ab4d3a3b441f1454656680a3ccc838fda"
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
