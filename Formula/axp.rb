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
  version "0.5.1471-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1471-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "2056a7d6b40aa57e5a64d1219f188811d4592d8235204c325767c16f1655d412"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1471-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "cde324ef091b9ce66902fa31f1512c71a1637606ae9dd64124606c0037d7a074"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1471-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "37156526ec8b51faa5e07d7fbf85124bb43fbb2c66b0c29da79c1164d2f783fd"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1471-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b02db521d0deabe774f8ec499a59f051489776746b6ae1defda9d310d55fa964"
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
