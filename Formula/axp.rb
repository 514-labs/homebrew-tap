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
  version "0.5.1760-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1760-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "3cc44aab1290031cc855d9968a5f73c036a9c808f4f4446301237972c5f9b373"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1760-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "1bd4ef51260f66a2eb5f7b21828f325ad0eccbfaf43729b7b85822367f6c291c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1760-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "38baed819f4312620c47c2bec42f603da65c4630e437b2a0e06d3ef856ddfecf"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1760-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "e9f6c9de17de0377804ad4d59e7721cac09fb4bd59a3b03cd76d7728e0440601"
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
