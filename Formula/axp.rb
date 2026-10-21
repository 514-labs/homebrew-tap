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
  version "0.5.1440-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1440-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "edbc028d94c33cea3923b829bf3133ed0792df0b2caa0bd1df2d49888ed94f62"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1440-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "90a49d699d7209a6a6a5f4d052d0fbee9de0154afc1622d8feaddc9e98a08829"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1440-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "154d86d0f401e7e34359396212e3ebc1f4ba13f7289024747dbe9adb25080a26"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1440-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ee3f7df67cc6432606db5b2bc86dcdfa5b7f6e7e3144163bdc819735b779a91a"
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
