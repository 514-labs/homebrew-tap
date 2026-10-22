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
  version "0.5.1448-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1448-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "6dad87f03d0da9f8d1db1a2c0ca2f3adaff233c04c88c142feb42a4645b63fc6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1448-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "51b591a4a99d142df85b413dafd11af1f54c3cd832c4430efdba9136ae687b7f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1448-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a409f19eab5139a2c6ebaf9b7234c5353533a6a9787a120e63f09be851141ef2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1448-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "cdfe5b67b68bdfa26c30b59383de5ae4d09c61af9dcbcb08a3758876ffba3d29"
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
