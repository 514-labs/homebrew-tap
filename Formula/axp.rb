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
  version "0.5.1240-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1240-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "717ae47333fb131a7983322b0bee9a874ba9c2fff6ff1ce0c8950b077e74c4dd"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1240-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "4f0bbe7b892a8ea589d4c46baf6110b2d0877fdcd49b7bc061489231bff655ff"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1240-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "6b1b56523ba1daf4d50a062cea3f513b59d031b552430ca8469f67b348d9b21f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1240-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "97e6ced89fb850d84ca13b128b761b29f029ec397433db00ce93f1a8d00c9109"
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
