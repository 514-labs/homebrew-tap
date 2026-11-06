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
  version "0.5.1662-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1662-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "92cf48671fd6b85471f50ab8766db03405129e399a624751f40b69f305686d1f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1662-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "87b188f46b88ad63c3a82ee40e5aa1bdc96595e782909d5e3c7137ca6294057a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1662-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4e4ed738cd5291af06c79217d18adb926d72d65f812eac9aef29f72e4c401b54"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1662-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "679a941a5df73767583fdbcae1eb103650a4f52b6fa71d95b8e15477870ce1ca"
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
