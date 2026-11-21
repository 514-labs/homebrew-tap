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
  version "0.5.1772-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1772-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "0dda30013a38088fff78dda32c64d859c08cda7ddeafa56a2e4282589a653ec0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1772-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "2b8a8facd487b6fbf94948334ccf91afb6f822a17e14e7780965ee8529a5e981"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1772-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "7925373853da766c042235104b45b67f0a7bd05c8bfe68167cecc9c1773caa39"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1772-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "0275f085ce52b201d0175ebe4b113c999ec6682a0012bbfce9487a0a79b2310c"
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
