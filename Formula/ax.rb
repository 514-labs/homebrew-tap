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
  version "0.5.1244-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1244-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "001e4dafa85d6b47921f66c14d9d7597f2bfd9ac48d93fbbd27f053236220373"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1244-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "613fe04e57a92821c372937b16a4a483e4a23f7ed89bf38e750b64b13257480f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1244-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4c56bcf44870db6bbfeac5f11fca469666a5af3a365ae15d114e01dc8ce17538"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1244-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "894069307621824838094c78c5c2bca20b6e1f62f0669e500120e471c25669d8"
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
