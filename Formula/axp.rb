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
  version "0.5.1722-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1722-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "42b255fe4403dbb9407feeffc71f0bcafdb1dd22de7563f432997a5cd91c1ee6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1722-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "bebda4f9e387622f8db20863525934a6c59a41bbfbaa8688217df330c6f6df75"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1722-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "74e9de748be02fbbb1a4bcd15e1d2a5b24c30f26d72c33f4a5725565f01ed468"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1722-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "8cae16afe01c5f98669fbaf0e0065ef7761e6b8207e2b2596bec6e533b1fb56b"
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
