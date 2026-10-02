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
  version "0.5.1238-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1238-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "c8076c773811a0730db292a8956b667bbb8b8b03357bf8c26949ff5798dd1537"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1238-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "e916a09bf4dff4100818061b57d3300b04e9f3752e9c7b939af692145f66ec29"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1238-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a1dd2220d59a64e685922e276f223724dd4f0d4f04e0171d03e01d6a55433eb9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1238-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "11b3756679de0bf6dbc7ebc85204e60d84f179774a6235c77ece12a3fddd50c0"
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
