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
  version "0.5.1278-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1278-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "7c55b2def3f362e6c96280340ca750da262fa67026a5ae9d54370e06673d2ee9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1278-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "e971f4da6ab4b5d3970900af101cbaf59dbf4af436a5d94d1f66e8d76440e4df"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1278-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "55ea367f0824a7d815e2f51e75c502e75dca24666e9d0bdf45e58ba73ebfc19d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1278-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "90b77a7671f84358b06d49f29a65021d441b642d4285fb7de79280764c97f1c8"
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
