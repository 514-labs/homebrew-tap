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
  version "0.5.1374-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1374-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "c3e0102a4edb5cf0e553f8bc29b2ac31a2879a36f557e4629562ae92e07d8b2e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1374-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "343309a21a30bddf2a3d33f3b4c7368a083224dd73b25560d2ad5d70be0bb80f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1374-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "061f830f186774b732d6907aa899e9b88fb90c1da7a135bab197fb9936868f7f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1374-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e2844dcd5d329234bd1d1cba4a54dab979d556f6ebec34ffef81976bad636162"
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
