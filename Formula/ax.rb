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
  version "0.5.1273-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1273-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "ee83cfc81923ee349be310f55abb6ec16ab8438935cbf4e1ff0b2820bc5911fd"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1273-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "524ee0231ee4db5fc1bb148bd187111c087bc5f6bdb5bddd43a9e7b7fe53a08b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1273-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "09eba7cdcf2ae866a627c34ec2d6e36b3e0cffde9de8018081d126a13ed6c39b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1273-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3c2a6383b311d9f745f19bad80675b011e50649a750c4d2464a4e9a1ade63477"
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
