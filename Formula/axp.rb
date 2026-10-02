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
  version "0.5.1228-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1228-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "f9618dff703b5b58ff049b1334a84790a8f49ba10a05e7942625d051a46eb855"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1228-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "ac74943d9d7a5db4823b3e4704071e34051a88e590cd7da4e16d1916d2e7c8aa"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1228-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "5662bd230f6b9fde04455421f9605cad84db0576293b4fe4bbb167c30f4da7ad"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1228-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "cad40b66d74e462d87cab6c27c4c2288142a6b1ec96f42609df830e6a4b0da71"
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
