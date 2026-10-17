# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `axp` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
#
# ENG-3612 deprecation window: `axp` is the old name for the `ax` CLI. This
# installs a byte-identical binary that prints a deprecation warning on every
# invocation; switch to `brew install 514-labs/tap/ax`.
class Axp < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.1410-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1410-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "81e099e12b86b3361a30510c70cbe62f6fb52beebfbb8c3a46420200587af171"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1410-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "18d2247f30b98e5373f5f7ada1b9a5dc951d7e77129b4ee1525d9cf6ffceea7c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1410-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "13fc3c2e49151e9e34bc1fdecf51e4844e8e04f7b7e3aa1dc79925ab489d5eb0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1410-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "87fc7e9643f31cf9f9ab2e8a83c39253a21f60daa406aa31c871f888b8fef4ac"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch archive
    # (`axp.tar.gz`), whose only member is the `axp` executable.
    bin.install "axp"
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
    # Keep the smoke test hermetic — `axp --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/axp --version")
  end
end
