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
  version "0.5.1253-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1253-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "feaa1e5a558d6cafd5aba035bc61256e203c99438db8b678691e2dcdc5f7d115"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1253-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "f64e374d69314b8dd0237e0fc054699db711db2589ebbc6960e5bf3c89d84714"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1253-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "5cdb5766c2f537307aaa656acde1fe35a3e6ba5bbc8b538db769e05a21f3faa6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1253-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "19d5621b9b8dcfc3eecfd698a55a3af3fbef6ea281c2bdf6d3e3e2a3cd0bde98"
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
