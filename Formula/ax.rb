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
  version "0.5.1767-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1767-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "7ad0889fa6d1f75de04b8cfcc6120c0ab6fc9b602363487e7da0212083fb9ef0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1767-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "331446ecdf02bcee6a7afd56cdc3858c3a879673de85bbdf0944c5383841b6fa"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1767-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "7679f094c516659f19f608cb06e567c8f40ffaf52619f45f1b5c9ff4ecd04f10"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1767-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "809d2888551409978c49865f30e7a9e2e219354a63ef678b439ef113558c6ada"
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
