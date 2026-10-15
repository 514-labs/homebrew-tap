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
  version "0.5.1363-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1363-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "a94d1f4e153c31127eaeac0b172b4881e5126a05caf1a0a7b4724c969e7e222a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1363-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "db5f541477e9e2c7082510384ee9e87bfaf95e91d8c78eda2680c9f07455a63a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1363-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "7d92c476576852d2240f4ac3faa729fdd4613f0ea55177379d6d381178407cfa"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1363-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0bcacf32ce6946359644f4dd1372d648d44429389323513af5e290b9828e868a"
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
