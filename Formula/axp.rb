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
  version "0.5.1495-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1495-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "2559b161f659990ae49c487d1dfc0917dee22a167909e5a28b72f622141f6208"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1495-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "5281a587148e58d448eee0b968a5d030afc0856aef9dd5da5415a2031d24349a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1495-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "1ffd6ff3be15eb1e6e1d2d5c11dd610a174d0535047ed5439229f2402e1f6b4b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1495-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "acd968626676a41c7e646054bec918eab3e280ecb80aa543c397cb3cc6596f61"
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
