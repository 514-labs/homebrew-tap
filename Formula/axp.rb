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
  version "0.5.1538-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1538-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "49ad7fd84d6f7d301a80aa54d8e8bb1d0a815ad28a4d55e8a5322e404fe28eb9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1538-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "e789fb1a03e250128e0a6b12336d32b51d5c6d8a56e0213bf9b66d0dc48b3d09"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1538-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "a7a705582637d7ce514dc837dfbd667b0760ca864cb0c41de48193d074384edd"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1538-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "2e7f09b83396a6b9cd3fc88f2fc07b19e39e9bad4ece59056d472f7fba57db08"
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
