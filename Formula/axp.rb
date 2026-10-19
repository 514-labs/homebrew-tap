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
  version "0.5.1421-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1421-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "86758238b86b7c63adb4cdd8aca692e917f1fe37010d083b9c93308854d6db3c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1421-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "ae4ebabfe5defc9021b445053d7922a821b969d1f7ff836ad3e67983a3b34df3"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1421-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f09e7bf6422ef7f9920922b00daa1399d18fb929a4a180f3a282a11372752499"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1421-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "bba54065201fca6a5ec350f8b265a6edac5ed34e6603e6204613026aad1cc22c"
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
