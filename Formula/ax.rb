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
  version "0.5.1655-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1655-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "bf16f6f03e0c0dc970f27964494d33eb92fe2d86d33f0c6afee492272997a053"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1655-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "b29d6f4caabba7d85ad6f8d46581c62c57e14a6d718973d0c83db94fcfa57ae9"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1655-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f6f11c6cf22e4e534f9f039f2fd3773792b92b8c7636ab0ec2a6003aa553246c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1655-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "23f0c8140033b0e6386972249f42d224dd57626821d11c9f655e42e37a90c33b"
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
