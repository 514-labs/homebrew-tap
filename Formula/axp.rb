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
  version "0.5.1277-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1277-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "a144cce46fc8818d6681bf048271d5aa58bd7a05965823716409d3e8b548c37b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1277-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "51b1bcacae57fa07a5db4295766135d2da59717745fa09dbcf6438731be68b0e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1277-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "c18bb2fdafac189e891e5a98b874fde1f57b5b5568cd8e12af26408517d6e02f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1277-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f6712d718f318c7bb9760e23af9dbde0d0fe9f40f6fd2722d392a2e54fa711aa"
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
