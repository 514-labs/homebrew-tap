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
  version "0.5.1400-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1400-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "fd38a6b27a07e39b16cb629fa40782707f2f3efd4d08ee38f0f90807c4f32d00"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1400-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "261ec620a20092e4d288535c47e7e9acbb30826820bd1278723f06c4bf6105cd"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1400-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "4f2dc5cf2b4be8d4e2115a8be1829616c92ff6d399d582e5662ad9664b9e75fb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1400-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "9ae7d9f9a493a0ded792c4332dc0b187a3682346d85348c1462f13a1718150ea"
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
