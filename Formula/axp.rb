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
  version "0.5.1503-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1503-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "00cb2ac5dce334c1b40a1113664fbd96878a3cf0d30c2eb2a51dd1b15ad40bc2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1503-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "4a8ec360f96d5882ef5f2f26dfc7c86df306643648179250939fba33f8905a92"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1503-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "2ec43bc8a7959b23643e68c4ce795d84f9415ecc911c4e48cbdfdfdf062bb901"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1503-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "97d8b52f9717f9570abd40c6fec41c33efcaca725e40c77a08eaa264d7d458be"
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
