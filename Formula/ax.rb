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
  version "0.5.1407-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1407-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "b7e4dfb815f2a461935598edbeaf40810d16cadeeafd43e99af1448b29f7549a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1407-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "effa9c11f045a560d268380b1d96d4f20bc2c9732822ec6dec499a4cd207cc6d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1407-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "54b21127b021c8e1b4e4d566677971252c2f9ae196baf1da02287f7c39594737"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1407-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "021322ef257f2472059e0e9ed5daff3bb2b4e10cdddffad8560b1efc534ad883"
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
