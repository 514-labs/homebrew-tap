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
  version "0.5.1691-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1691-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "023a23fd96dd1d2da57d57f2b966b3a85ad7b1f4fd0ca2d486c3545d40c5986e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1691-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "8e6c1035ffc49ba0bbfd1e9138e5969a5441e682432e7a6fd26411a09be14b1f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1691-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "eaebfb72a492d3d77fade5ebc2fab14aacd97e567597272e5710baf6507305ea"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1691-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "54f2b40fec795458035e8fc5fc2f37e46cb88144706e5c4e52c1337c39d9667a"
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
