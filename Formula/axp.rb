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
  version "0.5.1673-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1673-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "0316711f693ffdca2707c2316cd56fdea96a13656fde1ce0e42e564c0a6f304f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1673-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "7ef326d39575ed3688159c4bc2cf7e72d1a03a2d6a334745eed3876bd88aaedb"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1673-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b21108775a326306020e6d54c6788478f7acdd20c4fe6b58d1f76e2e4f360122"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1673-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "cd1029ca5cb4665bf72de7fcda94575fefcb53bc2dedb021bb1affcc8594c47c"
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
