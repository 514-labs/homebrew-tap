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
  version "0.5.1448-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1448-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "fada6e4dabff2f4577f27a9c31cfe9d857586c02df2d265c129a457ede8e36b7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1448-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "be2aef303d529218531a4c21441bf03375627598ea5e0e4107f95d794ca24199"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1448-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "6a1088ecad2ca96f7dca5617b5ce8aa2cced81a63e46f3656da38c0e7d0078f1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1448-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "1a67e591ef3c0d99ef71cdf12a04ef08b468f23a050240585b4a3198cd732174"
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
