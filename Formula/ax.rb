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
  version "0.5.1683-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1683-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "a434ea2c5ef74306b880bba15d6710cc74b3753a34ecedfc6582b60f0501dc38"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1683-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "6e3237f43e674d16c15929f76c7b295e5ea75401f335566888431a4fbfa19611"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1683-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "96463aacb59b84a22235f08f4d0fe1714fdaa27e3385f7b429d748947b7849ac"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1683-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6566e84483076a486d9b043af9bb873f9eb28e4fad3d502905a83fef7a1f0976"
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
