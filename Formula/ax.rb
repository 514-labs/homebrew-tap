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
  version "0.5.1566-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1566-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "cf89e09fbd67a978bb68f9bded852ed2f1778db268b36653e0b94f101168fe53"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1566-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "24304f99ef240b34caf499f41b5be2615dae60cb8c32daa22dd038819855ef42"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1566-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5e44543f00f221699d6947d04c302d66c28ee3d5a57fcafca6a3e214c68c3833"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1566-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ffa2a45a20b31c09b89ff2085479ce3e0950c14070e8179e63cf670c093e67d2"
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
