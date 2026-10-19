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
  version "0.5.1413-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1413-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "d91be5a834aaeb9125776e7e743c954e94c38c9e78c9822ba9f1096e6bc22f7d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1413-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "4d02882fadb97984716fd32291c3eee2d242399a7e6436554dea6903b9fe409f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1413-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "73266085ac8ec3e1973409a4487fb32052158b6a618eabf838ebeb671f0c78af"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1413-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "5a7bb6c2468524c201bae20acaf40574b0810748a7fa7add17266a0665836c58"
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
