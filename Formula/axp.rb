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
  version "0.5.1762-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1762-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "2b56b806803f8ce22b1d98192916b7d1b7252cd67a1e2ae91873fa8587e27561"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1762-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "aa47b8c6c5a3b25ac120a05f4a79163620ac730ea554c78a1c2070baaf1ca758"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1762-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "821ff543cc570923aac4b3406430588933f494528d358c1828b754cf7d8d5716"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1762-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "979807c9e49bf9f77e0d6a548e1d3f08881e979e5a7bd055a4d2d1213799a747"
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
