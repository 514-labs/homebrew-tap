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
  version "0.5.1242-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1242-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "b98ca695894709db97629556b0b6de23a16126ecb68ab89dc360d30407daa690"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1242-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "62383ce3c648fc3bf9dc3360e803af05797511ff2aa196222c8cf591aaa18b11"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1242-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "475ae21e5b99fc0f913e13588df2cab47a8aca5711d34573e693655c7246285f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1242-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "fbac686ac33d9c75d9b0a827336c99d424fd74fefcd754e299e4573e4909a71d"
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
