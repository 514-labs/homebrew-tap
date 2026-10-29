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
  version "0.5.1540-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1540-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "d239b03dcb27216f6c0c9da66bf8e2b84ac1b651ca8b4222c2ce01ec3badef90"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1540-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "c92eb976be722a05a744e7429a242c16a1e957f3c355d4235fc85db688d8fdb9"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1540-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ccde6a615f102b0a172451cec337181a5e878af0a04ab81437d79aa1b7ab89c9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1540-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "9473240e43f789ac26fa74fe776551f2b54204921632a988b13f196ee8cb7f99"
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
