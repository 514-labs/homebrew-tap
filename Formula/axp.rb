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
  version "0.5.1490-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1490-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "fe428422d9a67c85e0c2892922eb715e5872ecf684058f7d913d5b8ac06b2adf"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1490-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "3ac88bfc1aaf29a623fa2f578d7d6f3e6460845cfb6f8992be260d27e54f70f2"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1490-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "7ddfaef91b4af739d6b9d58d8961ef6e9e5f5d5c29de9d86a58a39cedca1c03d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1490-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "a38ecd7548249433aa77ee047049d224d93de355b1c45e2d66b194e0f08f0281"
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
