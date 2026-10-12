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
  version "0.5.1325-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1325-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "9470d70b95a37701c32c3b1215fee116b9575165298995c81e99e89a5b0c2777"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1325-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "38f3e92d3bab03ee7e7058601e12e1856e1d1dd0ed43389c16eee19770fedf9d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1325-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f30e469ad661ba3699dc631767ae6e2284186a6b13a04d389772ee7141fabd6c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1325-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "29c485d701f6a4e1a463b7908a909b9855f1c109e087a3e01b210675d4bf2095"
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
