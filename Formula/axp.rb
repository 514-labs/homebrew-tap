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
  version "0.5.1683-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1683-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "d5e7f5ac7282ecb0f20c8244d75e42cb3b41d2db1bf2d0c4d2c09ffa1b3f292c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1683-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "c7da37eda30c7befba4be95671e13e6a415ca269e40f7da8da36be0a070ede49"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1683-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "8a0ed697c7ae60d4056d87fdebb3136ed8c4c063125f02a821210ca90776da05"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1683-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "6d2624a4fc9b7e6639495e4132e8624bf672f48fb1ec9b65a1cfcc9f7715a87f"
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
