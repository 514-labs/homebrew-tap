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
  version "0.5.1284-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1284-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "d02a3b078e80cdd8bb2a8d56b1aa76ad618782e03e5abd7f79d122111a85c896"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1284-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "3732f85411f504bf495d194ae528d2351e09baeabac187c70f22407db300aa0b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1284-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "7095b16e658cbe9a01f90c196f26ee8f5e1c21f577190f23599067779ea32afb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1284-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "adf24cc10e07028500d835d1cecba4b89d736293dadf8f29d2348b9adcd8a78f"
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
