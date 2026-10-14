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
  version "0.5.1350-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1350-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "bf52eebdb5d13967828a18f10df8ba0d8e264bd6864547d79b977d5214307272"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1350-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "ae7fa51455471df6cf15cc219662da90a4c723eac6c3330ab4879f4d5833a7cb"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1350-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "bcab418a2c196f13e2d645cb7406371f1facf96cc961aec03102dd75f81825ae"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1350-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "2b58ce895a7131bcaf1df93ecf4caf0474c0cb34e08907befdfa4ff2ec93df14"
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
