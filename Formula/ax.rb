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
  version "0.5.1366-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1366-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "71ab910efd30ff41958c661d7e6f9bdfe085f7a5bb9855f7c1c37f65cc3877fc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1366-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "64bf244c64ccb13b67ee449af9d4d420705694179286a1d8f24652a69b60a467"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1366-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "178aeaf20c93bf3d5f43ce2364de91652be33391382ab297dbffbbc18772075a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1366-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b9d1c90c8f09e7e1c499a448a91709d1b4a1a7c96d9adda3145ed8a998efec07"
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
