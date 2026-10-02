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
  version "0.5.1240-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1240-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "32eccf7bacee5bd9753c758fd0dc4a09ff289b830acbe6d9386239c7e6e20ecc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1240-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "651c3970b3ea122ceda8c3f070a453eff4e19aba1df94f65a9e3176c03b822bf"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1240-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c725f2da25bd552e6c8910af0111b5d992692cfb1054e5278d13cb4413f863a9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1240-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e173b3fb125181691733ba3bba8da4df71bea7f9463ccfae6abcb97be06e5af9"
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
