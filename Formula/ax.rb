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
  version "0.5.1765-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1765-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "6750612a2815f8951daf517112c1764736f7782f9952e613a40c5dab7237d8df"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1765-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "36a6df5e18c17874f4ee3b19422f2d7275adf248ae4801b6e918b222ba90b37a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1765-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "afba49f98e2374abfc154f3288aa627dd55f70296814e91335e3e5b624698fd2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1765-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b2345039fc2049e74b852a59c58a5cccf052348248af223fba6680b6a62e3d54"
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
