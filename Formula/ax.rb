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
  version "0.5.1794-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1794-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "67804c6d917488ab16e9e2077883fc039dbee84f48e883a538c9618b1c7fa155"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1794-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "54135eb22b03464d3adfb93fd8d51ad38bdca40aac5ca3afd11c3c74e24985b3"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1794-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "bfe20087ba8cf6f5c53bd39ab1afe32899e8f9c2c85256e2db7ae864630621a8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1794-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "39cc02307aab66890e8d2002682bda4391f8b90ad4ede4d61e7b1c35b3f145ad"
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
