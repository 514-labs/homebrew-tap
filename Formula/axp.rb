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
  version "0.5.1678-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1678-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "0ca11d0cd379f745973eeb62ea6d57066c647242b112cba1ec03b7241cec4b55"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1678-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "5dc655df6f66e22469382bdc16bdb8470dcff9f38b4c7c7f91e8b9e1839e1bbe"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1678-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "1a6a28b0d8a78022d9b95e7b4a644183372df9b338429d27f59c069241357988"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1678-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "c24bb845cbed86bffe140e97ad2bdaa631d4feb13307a4bf784e8de2ec620d9e"
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
