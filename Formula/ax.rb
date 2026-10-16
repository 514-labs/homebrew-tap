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
  version "0.5.1399-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1399-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "9ae999e05ab8f6b58a74e6d55b8628ffc95ee37e87b9bd394e2173232bbe1045"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1399-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "e2f42dbdd762d6b7b5e0cdabd0f23ccc22db795888a6ee5c8633fcff0bde3e10"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1399-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1cf8bcf3962d6fb9ad512af452fb85749367c06d1918440daf647134a1f34936"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1399-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f973a6b2c5bc721153a9a5d27330e2a4442c93986f2c520c5727108176a43c72"
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
