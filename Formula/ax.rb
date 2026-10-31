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
  version "0.5.1567-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1567-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "faf86834c4041dd48f6a1ba6d76be6840b58ec891b3d8224eef6dbe73b3e88ed"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1567-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "c911c71c66596d392dba7fc58377f82e22c11451616c117289129285a70e4384"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1567-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4077e08e91611a16cbb796ebd04fd57b0cf1990b9a2e1f331c1e000e7144164b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1567-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f9b326046abe91749c2358c1341868e987f359bdf40f420bb00a7dc69b86ed66"
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
