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
  version "0.5.1519-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1519-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "dfb68f0a6a144968003e8b5a185d26b78ed902ce05400ff22c0bf77d04ecb2c1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1519-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "1044c181d099a769ca0e37d3400d5a6233b81aeb1000c04a405e35a32813a590"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1519-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f73b152837902024a636cbf0793eab6b1e03c28f935b51fbbe9ac8777d847986"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1519-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ebac11f596be6fc34b477905a75a79ba1080101fa9a2db3335f3001677dd3f65"
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
