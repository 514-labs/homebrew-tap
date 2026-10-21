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
  version "0.5.1442-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1442-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "8c57f8ffe21c6bfb90b17abbc18169ffbb1e1f00955d569495e502224fe853bf"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1442-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "6d517ce7df8c361116026b7299034d55c9e6f38220aa49bede295368c156a61b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1442-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "3cf0d237da48038f50fb9dfd010b783f9fe3ac28909c9afba3f121686a677b8b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1442-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "eaceb3b1c84daf6878216fd4feaf9f373b46afdc2ae590b23be9900edfd05c38"
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
