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
  version "0.5.1794-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1794-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "5b13a6a3904053cf0deb3f9259c65add17ad63c3bc6d16590f784589c9cbec33"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1794-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "61723dbb482d8dafe55bbf9c008a1bf3df30b9977e82f8d1779a001af725e0f4"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1794-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "6c3a3074f8c7d789ef1766122d61bb0e2cd377d35900e4ce84e766a54bf4f128"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1794-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "06f40f6d1f6513aba3b872f1f84f064c18e948302a3db48926d2d719df907522"
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
