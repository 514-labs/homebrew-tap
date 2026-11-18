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
  version "0.5.1750-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1750-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "96299e2a9623d6a64d12f9e5611c44d22ffe02fcaddd7bb70d79f4ab52a5362c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1750-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "dd9b15b80ac3c300132bf796e385eeafe3f8a7792ef2cdc6a131d33322cb9676"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1750-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a0ee7c81c021d4594b321412908226dca3c4fb11b4a5025ea38ed578a1d9c8ba"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1750-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "cf947da3e8b46fe041a1fcd802c5cf3e7ad2ad5a722329895700ea185e9db148"
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
