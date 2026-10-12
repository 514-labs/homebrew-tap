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
  version "0.5.1329-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1329-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "2a54c71c9bdde00a64675e756b5d81bc5e24e82ddd3da2d372e854156eaf023b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1329-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "b7e16c13d076c085888c5ae6580cca6eb5c8a9d5c73fd8ae36237f231b95bc26"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1329-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3abb4642b36de3aaa0f23ab63da093419efa691e8b59ac3c9696f4b2ef0746e7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1329-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "df296491099558b5888d8f25c4e735310a594e95dd0e5f959689b2d6604d4908"
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
