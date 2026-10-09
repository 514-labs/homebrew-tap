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
  version "0.5.1299-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1299-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "40054c05444d283d77d5b4b4685466dd4749cc2086a12bc7fb15ddd778c84855"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1299-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "494388d7b250079bad94251416775b3503625a9f6e97b51e37b51b84b804a044"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1299-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b08f3abef7893bdf9ee4ed85e215b0917088ce37a3e72456857cc47dbe35f7df"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1299-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "232cf76a096cacc7b2e8f09192ea6d8ea09cbf49f21d67a92c22cd37bc487d3e"
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
