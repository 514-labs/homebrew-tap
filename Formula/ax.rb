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
  version "0.5.1461-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1461-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "41545f13b6aa95cdca2767fad4808f7ff81bfab5e29573f96ecb102c560d9a5d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1461-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "1f491af1d3194b646146854caefed250668186d9528f4bcfbc868455f624fa70"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1461-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a4df1506387007ccbc569ade1d8769b36bc77449efd8a138dd5fcc458280ec41"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1461-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6dc16c662ab1b5010f5cd791d59e37de455ba4de63ea6e4efecf46bbe32c2dc1"
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
