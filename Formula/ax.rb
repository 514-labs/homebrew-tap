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
  version "0.5.1630-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1630-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "8e76d9ec45564f530ffd55618fddaed1c9338605c7a0f9e802e7aaea7013e3d9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1630-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "e89c9f492bdc9cd3601238229dfcf226bc2ae9c5973986c0ee126d1a76158da6"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1630-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f5ee304f68668dd470cadf69aa989c6d6afd0629ad415f2d6e456fad1421214c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1630-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0d8754c683d0d885d33517f284d17328e3000a91bf818de91f9d32249af29849"
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
