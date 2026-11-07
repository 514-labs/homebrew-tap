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
  version "0.5.1681-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1681-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "30546d14ef9a0c3f21195112d3ebbb1f13a280b47527f61c94687151520f152f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1681-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "9ec0454e31d52f3506781e27a8ed869c682eff3ff7ee169462bed1af20849f42"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1681-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "efa04d6ad958e4ab800aa2a2380171d5e3bd5c28a39b2d54695d86a6be38cfa1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1681-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "80a1a7b797ed6038e2c12bbdb6f0422aa745ef73e7786d69cfd4100100cf59c5"
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
