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
  version "0.5.1528-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1528-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "f14c6146be4f0cac5584f78e9248b1becea8dd8de00fd408869a86fd4200bc92"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1528-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "c88807a0a713a68b3ffcaa18b3e0e36101acc4b303b97dff526e29b1a8d6491a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1528-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "fc4e68fdf879990e42c2a60101a42c9e882342f3e25bfddf38071590a6d93480"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1528-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "1a998579a2ead1962578a5c32fbcd5e85a3cdeff89865ac3441d0d25ff477a6d"
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
