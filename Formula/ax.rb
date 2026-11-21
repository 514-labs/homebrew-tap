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
  version "0.5.1782-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1782-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "9e3c7d3656c1a0a77d0f0eb03ddd5414fb1e7868a583a0cd11e3d20406ed50e7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1782-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "948cb9f458716042b742910f4e40c113e5841d42ce906673e08b0465ca494b14"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1782-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "97e6a026782c841e8c1a8f72aa63096c916190552dd4d39d45b4022f8d4b90f4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1782-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0bbfef6fb870f232b98d525713bfc4ab81eb82377586b81769da042a95d4da53"
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
