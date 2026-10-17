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
  version "0.5.1405-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1405-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "de27604846b2d5c6c74dfc1e3e66215be824b39c7d70daa7cab4bb8a86f88bd3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1405-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "2cf66aca9e030db0c2aa3ec22021c7dce1692c6e4ca18a76c7e9374c0ce01e73"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1405-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "959a1b45bc4cd845957ef5d1b507ea4ce01745847a0fb2bd18ff5f7225b5404d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1405-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "af1e9f4a7fcef7c736d6e61e923a23d4bcb59b6782c5cadf18cca515c9ae43f3"
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
