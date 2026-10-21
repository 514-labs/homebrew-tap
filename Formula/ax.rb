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
  version "0.5.1436-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1436-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "6434d07d943a47086d8976014b42cedfb63f0daced67e91ffa3b93f151dbb737"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1436-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f2316268ece558be6b79a658a4a49ea72a36ca212a012f996dfe9ec9366cfa38"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1436-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c221a45ee8b80fcd96a39aa6d3d8b174d4470f3d5c41f0536bac39fea206044f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1436-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c368001493a34885af503039b7fc503e65757348c19de7a0d401000bd86bd5c5"
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
