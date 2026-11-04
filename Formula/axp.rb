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
  version "0.5.1638-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1638-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "0039211de4f6a15d877f19a36eef09ad792c1fbeeec25214c607617fdb387dce"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1638-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "cfa3abe091d0d9335aedc955842e6142d89cf8e4c4e16f4f8f3e3237675741d4"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1638-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "da6028e7a95950d4ebbe29c5cbba922daefa13091765e803bead12c8ff3bc5da"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1638-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "9020af87ae55df9d0e5263c02cfd0d5ee16d46f77518ca9629b02734128d41eb"
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
