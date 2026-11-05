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
  version "0.5.1648-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1648-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "fb7dab372b80d679e1785e61feaa7bf3bbea89f15beeb79205d6b80fbee74b8d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1648-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "906c9c994031411681ef3c8541c5e24eff28339849b9571fe08e50b8c2186e1a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1648-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "98b187f132994524a79d4437d450a5eefa9852af753780d5ecaf162511548194"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1648-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8d3220b303c730eb306450bb69850baa8e0bcc219b9953ffc2afc9483e683c9d"
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
