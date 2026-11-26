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
  version "0.5.1793-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1793-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "8810f97c4f8328d467886fa129dd6f408021aba0b15f9f3eb0e02163aa932f72"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1793-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "45324e7c1b18047556a0870887b226fe4e1537cb6b6186ea8429c21cbbca7c0d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1793-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "91b61739d9fe413decd314df189df2989b96343401b6c6bd4b92dc7af7d6057b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1793-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "a0178c25e4c21349870b9e961c662d2c73fcf0d3afeec3783386adbda68f1247"
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
