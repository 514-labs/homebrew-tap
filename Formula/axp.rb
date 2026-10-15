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
  version "0.5.1364-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1364-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "7a209146d999f939462fad0ea0a3a92fde2d2640c108516ab1ea97ce45d25137"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1364-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "425a8e1f39047f66b4a592964ca8f98cdb03e03fcd72afdae6ce019e2c439b80"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1364-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "0d25f524d49a06ea213fdef903519441f8210436fb545f88e976114258992c7f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1364-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f40193c72475ee7c3d7a7595bedc3c0d67a83b4da5c01eb4e164a14af1e971ca"
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
