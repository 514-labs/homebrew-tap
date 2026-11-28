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
  version "0.5.1802-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1802-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "b937f19f072e7812fd13cac27d7a3eefcf08e0a821d665e4aca3db1841092169"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1802-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "73a6153775fac81d7c2935bbb68f8c632de80083c40cb47a87d4b21944dfff47"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1802-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b765e8f9f69959a568127da0b2ce6c6e4afaf3e26203137639fd1eb7dc63d978"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1802-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "941a0294bbdbaa31c175d518393379fc53fd07003bc3472851b82e25ab5e5478"
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
