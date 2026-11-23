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
  version "0.5.1787-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1787-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "af2bc80d2ba76dc7dfcf49c8f2560dee2eddfbb72dd48b327da70f15d97c8fc1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1787-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "88dd2b26ae0c6b45291c10246d25d99fd565df7b51a73905c1848aec6b8d5f69"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1787-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "101ee2575aebdba60dabae9fc368342c06753bc87a252acad9988a1f61c0c282"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1787-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "61efb511e2fda8c146d63351ccb39f36a0c350e2965783627dcc7839b8b537ee"
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
