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
  version "0.5.1671-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1671-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "c0b975dad6ec0fc92a42efcbba444fed229c1672c6638f2264da7c4197aa9d79"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1671-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "2a1013d683d53092e192c31992c10b59b400626118612a0dfbf9c1a7fed6bc99"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1671-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5f1cd6ae793adaa2aa7d353a03a839e2091e5c3557864ca228a89a92fd5379ea"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1671-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d0186d50cbbca31d588b9e70c714024dd75ea4123d8abad2f5c0cf23f5ec967c"
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
