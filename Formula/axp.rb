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
  version "0.5.1386-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1386-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "ca0b14dc0e8648d48f41f50c57a90b2a32cd4bf0a28764d8e75f2ba02c947f01"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1386-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "fca9b4cd79691b8fd2f90cedfe08b1cef60aa9211a7269aff6c06feafb9e2d32"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1386-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "74a3b0d60564a6f6139ab097970c1d0a1f91312b28661d741f4b414951b54883"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1386-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "3c0d464d16964f643395dfa7535f2ee328a64d86d597513de646f83a7576e303"
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
