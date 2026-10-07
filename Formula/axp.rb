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
  version "0.5.1264-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1264-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "aacdec119815456be1e32e86e3d9e65e88bd448d2975fe8b537de0adb7a91a19"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1264-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "f6892ce47fb2d5ffc9cb7549229ed4d95e5073ce70e5f2fdee69acda66197f1d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1264-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "c31bd986c2b1f643491c2d704fac870d4619ec81e999e495648ad1fe13d71ba8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1264-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "0675bf7f20676f0741f4a3138eef36c25c412c87e284b6d645c67a5aed0c63dc"
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
