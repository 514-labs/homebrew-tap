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
  version "0.5.1775-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1775-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "44deb13a8416795265dceb4abd0bd9d2f58a175040a71498df4a83a32ed72fae"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1775-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "534e97132fef941ff5ef9f2711a0a59c2dc6019c6db6efa142626d1157e5f373"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1775-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f1e4858830eef8f84fa091cb90daabf7f7f3e3284f7b5d18ef484a063ea4edef"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1775-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "532f0ce985fc4781dbc874f474e5fecc9c33d63bd3003fe30e7e8b1adef72327"
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
