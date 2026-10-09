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
  version "0.5.1300-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1300-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "afccd65a48ccf4292140140650e60b1380bdae99b9e3270558d47e52f669c252"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1300-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "17ec1840f1af395d7f7c245d698b7f5dd639897a970642c6825f13b35d429dbb"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1300-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "4f6a7ae925bf43427e36fe701f543a03dddbc3b66d66116e0e1b304c11c48ac7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1300-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "8a97de4ac700cf7590128566f2d9ed6c82d9ba7d40afbe7fcab7c1c235ad8c32"
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
