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
  version "0.5.1301-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1301-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "64d36b2ffb3c3e688950170c5b9b78f840f62dd1dd7d2ae8d2b7fc6e66a0baff"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1301-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "39651f6c738271bf4fcd24922abbe4c211ab9c2707d6f954204121411ff294f4"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1301-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d2c153f9cbbd7ad9f4c15da02b18b33bb6a4e5a109b13ce54c0833a29c22d8a3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1301-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e77baa9f2cc48321ab3d0c6320bbfe7336c972bc6ab7ab30dc06acc44e05d6e0"
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
