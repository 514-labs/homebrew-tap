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
  version "0.5.1506-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1506-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "df5bcac3df2d4b5e7fe472195a12bbc341de68f79077c5bb28e66fd0f1d92d4c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1506-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "91c9b79a5b61578ea80c11b9b334d4e85da64f7a331f49592021d6c953395f71"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1506-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "55a98cd357c251a8903c6fcb6ec802d660d5ce9321d45c05fdc36963d470aed9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1506-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0ab804a8a8a46319fd88a6cda9299d16ef4a7634fecf7fb6b5df6ef8ad962147"
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
