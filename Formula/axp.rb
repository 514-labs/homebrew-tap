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
  version "0.5.1650-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1650-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "6ee13a12d653d86489e1c691fb40ab87196d96dbeff1a43e58852341a8169210"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1650-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "551db9bf32598ba0b3f211e21a6ee15adc4eb526ac5008c98f46ec828348d313"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1650-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "64ce7009836d1c7ffbc8465d041d35c524d4d0de5bc06d3543eac2605dd69221"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1650-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "2aee845af61e3f746f7ed1c76363d52675abd7dfb83651b6468637d3bcf27062"
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
