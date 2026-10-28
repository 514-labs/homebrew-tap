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
  version "0.5.1515-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1515-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "c21f039ff6ff26b95cae8e5349e571147eb590816839a9a8a75d6d6e71f8608c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1515-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "4bd486dd55eff668c2bebe3a573c4dbae28140780e68c003808845d21a9dbaa9"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1515-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "05717418c32a7110b25c85a1f443de8edbfaa806cea53bff01bbd4a1ea7f46e2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1515-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b15f6d84dc400849f11ca8f356b7f5c8f011923ad28209f010c10941ab6102ad"
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
