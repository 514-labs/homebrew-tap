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
  version "0.5.1715-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1715-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "f2f10f7d143cc90bb0c11cd6292a539c1a5055cafda39d647343d17bb59d2189"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1715-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a0897bbd00c2e7dbc9d5d837de70e45f7fe99f973a0ae661e78d74b2f8dc4c2c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1715-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e3a5a0bc2c5c892028cbfb6c2b3bbafd4cb095ae5dcee6a563f96a24f11b233f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1715-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "84e8248dc37685cf106535b8ffaf5a528103c7af892d5af830f90c2427fb9d4c"
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
