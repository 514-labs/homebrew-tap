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
  version "0.5.1311-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1311-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "4725d2eb81558fbbd411e193d364d7aee99e0e8ea6392b9b12c11d9ad35a481c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1311-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "27cc3489b2904081e84e92ffef49834e8215355fa2afcb2e630a8f73b55796b4"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1311-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "cca4fb4eb44f647d4fc035b948a9f08e18f8cc75846007e64c9d6d1b0eb0cc32"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1311-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1752d957631b5a7ebd1b9184cf8826cdf23b0687e641961b13280c15e0963562"
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
