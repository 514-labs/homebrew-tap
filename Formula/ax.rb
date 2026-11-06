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
  version "0.5.1670-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1670-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "d43d77bff1b09a7047ab5d5196f096ecd00aabb0b712f4a6083689d882bbd7d2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1670-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f395bdd1e166f5e6300f68c92a28a4193d8a25ecc4706feb3c0553ff2a68ff02"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1670-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "51f67b9e1f5b4cd05a2a993363aff002dec1ce45041f436cc76477a2bf62905b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1670-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c28edc6299100e1e1051536f1d504b239bf4e9aa8ba7c11dc19c4ee05e2ab843"
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
