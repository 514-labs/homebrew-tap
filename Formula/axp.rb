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
  version "0.5.1472-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1472-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "0225356671d92ba9d741bdc3cf8f04265209102d53811c3b617a91a110197d3b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1472-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "40f773c09e3ad641692ddf654245d4d66209b4c50724f22c462958c633c73008"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1472-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "230c7678d13d6e5a30de7d9ac12a79bb85ea793b5171612098a55ac28d1dd903"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1472-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "281f1c6be708f87dc79ee4902bfe50a7ec3928230408bd0fd026dccdd4aeba20"
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
