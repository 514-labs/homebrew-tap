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
  version "0.5.1547-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1547-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "615e82214ed8cc67795ee387a14ce05a45c1b01aef250a15fefabf14e08c1dbd"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1547-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "52a2bc8c7176507a852197afe8be59fdd6a33b92e45a37fa452835d26bb73b77"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1547-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b3f9c2c33ae269600233d608b50b031a4b32a0b513f8919c68a849d91bc38b4b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1547-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "31bd2c19ae686ddf5022c9b15456c73c3b29e0698d59c80c9bfa01fb2c28a792"
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
