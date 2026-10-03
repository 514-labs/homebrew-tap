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
  version "0.5.1246-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1246-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "fe9db499e138f09eeeca7aa3079a223066466fdfd1a89e67d3dd0db84966dad8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1246-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f24c4b0ef92e253a600805511460f198f7fb99fdd50522e9f5180ff6145dfb45"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1246-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ec881f66bfda722748757b6a1646befedec16e92aaf08a2ad524169e46548791"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1246-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0bc03cd15b0c1da72a210990d62dd96af3c17ad1f08d35fe758def56faae9683"
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
