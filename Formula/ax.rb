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
  version "0.5.1756-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1756-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "834d0333a9149ede281ce3c47ada9604e20b39e3fe7be0760af2036983bd2b4b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1756-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "9c04065bc6f8eb06541a65648f38e5791c91659ec7feb8aa495e2b90cfd621cf"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1756-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9e503f7578ac003a2fbbfa4f8172347e0336b9fed7beb3e35cfdba7f79ab73a6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1756-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "10922318bcf7ef3459c828936c29071e92c5f77b5600e6a414293ea29752d05a"
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
