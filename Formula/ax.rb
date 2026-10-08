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
  version "0.5.1283-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1283-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "9fd0d71984313893afbebc56a6a2da2ac1ab212370d9df889738c8385624b8ba"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1283-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "24e827c3e98ce8058029a49f3ce326f0a9b75b2c42aaa034b668a122d6bb770d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1283-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0428b3683275da10b9b148a001101bd02778dff81326f9999444d8688f4e228e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1283-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e5ba0d82b5888623116a8153b892d59fe74521cab37500e20124829fd02954b6"
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
