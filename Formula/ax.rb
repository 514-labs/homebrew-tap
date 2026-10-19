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
  version "0.5.1429-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1429-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "b6d55cdbcb19fe8fe0c08746775c8b4a7d5f7751151c7098843098f7b3f1e9de"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1429-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "e7864c2825b8e5be0004bd017766c5e7b663547477a76f4ab17b453ed74bc431"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1429-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5f42e5c17d72efc45c63c5022d93e3933a491b2a6fe1d32ac97c2c2509106633"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1429-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d9bf1afb4cb318fb08ea732e60d24327d032b70026a203de999c103b989bfc8d"
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
