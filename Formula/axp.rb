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
  version "0.5.1239-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1239-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "ee835db97fefb4684d243df3abea4b9868283e625212e41d47d3fd0c493bb5d0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1239-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "0aad733adf2bf00429f5c5f837cde32420dc72ea85286a6f6b2253bef07ca37e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1239-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "64472b926b20139e6fb8c5b30b694aff3dc44b0706765176cc16a62c5e4f1a0f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1239-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "bf05e41e928247efeca36a6388a492ab2f6314df4b419e49bba46f0aaa30627b"
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
