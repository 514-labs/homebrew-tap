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
  version "0.5.1316-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1316-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "e325403168db43940a43116847e13428d6cd44eb5170cc43fd7a47bdee50b332"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1316-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "26a3fa664befead0bb49f63a18b5efa85ba6a2cd9d202acbce44d22edeed7c35"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1316-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "39d9252729e60452c11b4cb95c3d3bcfb0fb98ac82eacbb860faa1d1cbed605c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1316-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "523357b828f41ad95102facbe493bc72c15d6909efd825eabb162dd655b91c16"
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
