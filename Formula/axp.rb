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
  version "0.5.1450-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1450-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "4fa1cccf3029ea1d5d989fa837aa02a8ead1a7e13b0fe33806eb7d28f8305688"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1450-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "d5d81bf77df13982cc4ee01611442531d659753dab5bf346987dd5022bddd006"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1450-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "8238a3836c9a0c133dcae22c0feb8bce72ddeeac61a2e0a80ef5e2d8e5978d11"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1450-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "c5cbfbe9f26fd4a4fa1f1c433f64d30c7c0d7217ee2cb91e8a893422667fbb86"
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
