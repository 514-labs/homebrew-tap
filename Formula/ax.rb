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
  version "0.5.1428-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1428-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "6273d8c6efe74102f66a0a20bd93d06fadb84f4ace18a7429ec04481f5182c6d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1428-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "595a04c6b4602145ca4a4af2121a37291f10559ccbd987ab5dc1269cb87e8a27"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1428-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "24f468e4a2906fa10173f98d1da1f7b4e7d9b9d1bebd970820749dbb0d172750"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1428-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5ed12b588bf83ee10d501ad53c2c814d4c9c98684ae64eaefa02f76912a342a4"
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
