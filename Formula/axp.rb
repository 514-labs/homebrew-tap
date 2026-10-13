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
  version "0.5.1334-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1334-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "767a615548e8ed99db18bf71071726c2fc6a19d22f1d86885242585bd92550ac"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1334-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "2e550769395969f821cec6ae734bb8c682b98b949944266211360225dd8b22d9"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1334-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "86edd074530e14cf2c754bd2d0afbc276a43b022649aa81e882b1606ab8b1480"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1334-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "5c56a3ba8352fda869a83c8716d4b82a8a49dcf841380531b2f56ee950878f6d"
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
