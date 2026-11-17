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
  version "0.5.1736-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1736-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "a7b2684cf1733da3c4f2f666613d29f8180d6ec91498024a8a9a56ba0e90a0d6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1736-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "a2b321114df77055261e5d84e3130744af3d856a9eb9a3726bb6a96403ddc985"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1736-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "fd69434f50aaf1ab89b3d4b471c889e7c8cfe806a21e76a3ba90f92271e04721"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1736-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "3497b2d6960dccda36479f8dd46537501639d272d5941d87f2806a15326fce13"
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
