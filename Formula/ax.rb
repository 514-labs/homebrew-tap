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
  version "0.5.1394-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1394-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "497bef6273722bfa18589393a2471546c868b91952f79ce9e469e932cbec50e0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1394-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "1816deb2b794af028e0403f920ee0a5dc8ba0c260fbf2eee9cbb7f7816dec66f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1394-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "daf6330117e70ab6a8831f4c7cf56a2879fe57b0e6b98be9a71b69441895d0d4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1394-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8b76ca0caed6ae5141d184cd9c4b73575c7fadf44f940b9444000ed1b9b3e3e5"
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
