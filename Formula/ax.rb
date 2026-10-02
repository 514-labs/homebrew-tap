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
  version "0.5.1235-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1235-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "b4f5085cc61ff38dac938f7d3a322cdc52afd7040478abc435fd1e4cee098729"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1235-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "43bc408fcc456a9fdc2a655b897bfba47c10c64f49e66ea57a74c6987b42d781"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1235-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "813debe4b48c201ad6df0db88b46411b303dba00878e7ac0e9a46e8e0c3ca924"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1235-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "effcf884d32f09c7bdb0bc52698894852dcc3147c191884bcf13ee0bfb9bcae7"
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
