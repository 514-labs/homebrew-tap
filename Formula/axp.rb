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
  version "0.5.1642-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1642-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "31f4191d680d0f0f3dfce3cb05be226012c6b74c769188ae6c70ad5bef0d7544"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1642-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "01fa44005f577f83a1a1ecdba5b7696fcfb21ace15410a6b3cea1f1f12bb0e19"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1642-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "1708b128af985e54869516596190e73f6d855cf8a778b9a2aa6f83bf24266a6a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1642-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "13977dfe2f554c9fcc7c25e5d863f3f71ae59c5b4b3ba2e105651fa76ee982da"
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
