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
  version "0.5.1665-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1665-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "22e3250f53ac5ecb5c7c331eff1cd18c5f294884ee16a8bcee4e60882fb7bcec"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1665-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "070956c5bcda18c3d6364cac57d8d43319b25e2a00982a4f50755a1980136e46"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1665-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "34d0f6ca7a3d850da5b71e082e03a8d2d5df93a707946159866dfb3505855b63"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1665-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "954087cbcb14cd6239460d7163f26e7c7884c32e29db4c452c57571f706e81ac"
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
