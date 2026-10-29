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
  version "0.5.1534-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1534-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "44897daf0dcbb20816418e07a14cbb428745d877803e191dc2b6bb211f1826cb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1534-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "9fa0d65594aa1ba6535e241aeac38cc126b85d51a1194ca2b549c5a6d9c996d1"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1534-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f68e3848d26b618324c5bca473fec20de2dcf35b55938e135056cf22452d2283"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1534-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "d4f6202af081848d164c0d0f585e4902e28d71ab9d56ea4f333c59ce82bf9ac7"
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
