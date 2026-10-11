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
  version "0.5.1321-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1321-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "814f1657ac1142a7963f18a174641316bf482f82e83038f5b6cf18d208b91b3a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1321-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "82b4cf82571852f526726c90e36fd14c244c9721a391de3364ef71c2395945af"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1321-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c7d4fb13ee53df81a6f4c3ea2a156523bcf23420f66ca8d86cf101c104c56c13"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1321-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ac0e46987244a09d55ab7c25007833422fde5426629de2a34fdb06e611632737"
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
