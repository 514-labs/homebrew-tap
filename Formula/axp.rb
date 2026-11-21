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
  version "0.5.1778-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1778-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "b590f7557889e4308da810784cbd26dbaa2bdead9bca9bba6fb07a9daeeb846e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1778-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "cf9753b20f07c6449579795b237c53c4b09567807b0015c7c39d1c0fd3c25da6"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1778-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "92a296f243f9a991703ac5b135773ef129d34601d931ec1a46f0ebf26f1e0879"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1778-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "fda8802e97c2e225b66c37f4cd3c4c1337fbe74767786180ce2c45b4dd8456fd"
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
