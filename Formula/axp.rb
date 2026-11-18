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
  version "0.5.1747-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1747-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "e778a544d093e0308466858b12a14f58dce182ddbc37f9592f878d75b81a962a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1747-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "7d5638a9a9089669741c07bbf842d61f9a9e96f4a7e35c4f20469db254a4422c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1747-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "193d0cdcb160c6ef45df65864774bec18c46133cd0a0d4f0088ab5506c02d89a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1747-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "c8d2abdd0386724640eb05a72058a3a8902e5da2a521dd077826d7b72279b906"
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
