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
  version "0.5.1792-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1792-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "d39fb22d9e85403a0e333e4eb42b9d46d6b9a00c472f929886651f1c0261c8d3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1792-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "cbf5f2f38c1a5cbe985b68ad00cf759433a738d77e129bdb2d4fbac0d7f0d5c8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1792-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3c681f90472e6246d07a65364be4fc974b112f21440e07974217b9f0f0d957b6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1792-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d763ff769b0c67f97205633f20a897e9598d4dbb2b40e829cf0c971e8f43512a"
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
