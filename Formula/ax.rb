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
  version "0.5.1449-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1449-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "32c80bada0c4f89fd4b5fd956d48af191375a037a2021c0b340ed636536547e3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1449-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "0804f4339cf611f0852f3fcdd9f14419acb06db0799915695bfe399bc6028c89"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1449-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e2da3709178a12e622bcbecc5aef9f150a87035470b48ec1c8a97166009f8cb5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1449-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2ccea96e9c20510ff8ed2796cb205980778b5eb70416b9be1a1a18a7f24cee4b"
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
