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
  version "0.5.1738-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1738-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "0731c951fae5dc60b59dfb5e795eef0888adc1a151d9d688684c58b8396f304b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1738-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "eccd2d4847e3af4e2c4db76ebf66adc642bd0a911609059e37858511bf23f56c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1738-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "37b2affda8f61c108c3fcbae30f7dfa1532ad413cee16f0ecef0e92bd4f0de4d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1738-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "cbaa31e1e90515e9357d63ce01bfd2a1563bb79396b83882bd458fa723450fae"
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
