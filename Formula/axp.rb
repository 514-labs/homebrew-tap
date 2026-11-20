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
  version "0.5.1771-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1771-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "4868998c6bef564e879c01163f503b587c2d143394deaa4f4e14939876c262f8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1771-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "6a0ff251fdff45a57770f065168d22086fccb24457fdc8b09b65f3bb4f64d4dc"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1771-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "8bc8f5dd0835d6263f369908b0e8e6721a3770a92f6f64eec58f02c1eac6c805"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1771-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "c7816d7b4e19ca3c3bce93b8fcbe8d51eb1735b51c3f2b4f0859f74e1c0d0558"
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
