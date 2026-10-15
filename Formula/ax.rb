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
  version "0.5.1354-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1354-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "702cd9f0636c4dd0d6599cb7870895dbd235fb89b07193dba51f4032c217f514"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1354-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a8eaad9209ced3a09a471f4b19cda431f068b00e5bc154ede8b249a3e837168b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1354-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "50090d723d3cd6c4427fa8ba110816a42ff97164f1dd1f524563bcba7668ddb8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1354-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a0e9c131537357ecfe814fe9a1083f3a96a79ab1c464e5c028b9ee52430f615f"
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
