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
  version "0.5.1260-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1260-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "5e7bc14f403b57fc04e48b551dcd486ea4b157dc7a1e5f362d221dc47f66a8f5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1260-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "6116cfd4e21886ec81df1d1cc688760c65c46262a75058d4372530f12c74da2b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1260-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5f331a50fb7a4dceb92024bce32576e626d87c22bace715ecfc7cbd26fd1e14a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1260-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "90bb3b052d1991914d5fe95ca7c32b3e7c6bc0bacf7e00237da132d9a97038e3"
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
