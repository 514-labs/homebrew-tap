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
  version "0.5.1737-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1737-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "57d18d7a6d09be6c3d2483292f83c8682e30572ec720a1854e1878ff544ef66d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1737-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "9e93e9bb2da18822b257ad98738fc4e29f4bfbb7f897893e177837c992d242ff"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1737-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9ad9ea59af7d5a8ffe7d463aa86ff4a212dd7404c3f4553e3c011ca13bc62b94"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1737-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "cab94d390fe04797f7d9632df394c8a8581bef001465639d448b29919fa4a21d"
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
