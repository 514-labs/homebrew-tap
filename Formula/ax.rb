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
  version "0.5.1353-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1353-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "7608c4f3624fa30575d3ecd9ac1d217a6e6b9bd9355137a054c520d738d0befb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1353-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "3a3b19258512ce0feffff453d0dcfece56962b4e685b51c6bbd7808e30c75ee7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1353-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "20ab512a7de315201e09d9547f064dd28f44c73f0083b8a6bce46d457c297c2c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1353-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "71d437ef8cbc4f6cd49a94baa3ce77c0be3ac1e2683c3efb043aa0a2107e7cbe"
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
