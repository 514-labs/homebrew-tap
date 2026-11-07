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
  version "0.5.1677-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1677-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "a1c23dbaa44143c5cd8fec4fc6f15faf2422c5ad63c34aafc97087cb34efd7a8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1677-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "981394b76ddab42e6bbe0934e3de9dfaa3665a671ebff84e48c2879aaa086fac"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1677-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d0548f4d509c68996fc2fc560e086f2e4b056cd1348a6be6bb9fe09fea93ee55"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1677-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e8187fa1b5254f4fd12eb60be3954c8838d6b9fe5e0535e35e0746b69267e444"
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
