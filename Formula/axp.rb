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
  version "0.5.1669-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1669-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "1043c6e4665de5c4ac3af7400a6e65cbc94cf2ecdc70f65bacf8b78686bdb09e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1669-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "c948000ad9e21d5b14f42029298b7bde67fc213ab2690a9c28ec3ec21359d300"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1669-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "8f339e939a192dcd47eae24a9ed0e38e778b62cbc661f84657eda202f5884da1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1669-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "38d78345bb1bde0311fdf2aaa16739fe6704702e4d7d79218fdb8cd7c8dd9203"
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
