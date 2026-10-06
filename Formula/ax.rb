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
  version "0.5.1257-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1257-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "8038a4c41efd87768e887472eadb3d028d8b1a70e4bf2abdbdfbf9e261de8e6d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1257-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "ed88af655758a5bc44e5bea54795638a61a2f998c1569485a441e288c841d473"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1257-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "aa9507b048022c9f5e46b27e6b0979c5420a237e2b1bc2f19fbe238725460e5d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1257-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a37ac6079964bac274019b23e0642f0df9823ceb9fe302d96469aecad466b9a8"
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
