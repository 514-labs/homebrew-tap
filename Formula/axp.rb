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
  version "0.5.1732-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1732-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "98826920088427273581d330667695f9dd96f5c9f4c17db0c7aec58f6b1c9bf0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1732-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "ec00b4fbc4a86c9e3114f397c6a386f6bacb1f2b0597e9acc0f9ea539092ad76"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1732-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "2341e51e0752cba164bc13e8d7e2a80fddb587e030b9625ce934b2555e4727b9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1732-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "8802c3766f868a0862eba4319545bd85cc0f8c66f9351abf216c162f07660d4d"
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
