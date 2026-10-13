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
  version "0.5.1335-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1335-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "d5986b4c29c059cc4b2bfbda4c5a09a9adbbf366e5c96d2aba012da67dc6555f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1335-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "e05efa209b546e6b2ab973ebb3877de3ebacb4d3e288ccbe7a37ce3675c8924a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1335-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "db46326334b36463edab6b3cee960f6256db778d10d717267fc83a811e6b47c7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1335-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "289343a9573433271c926571a7e45122a589bd8fd64cfa7dc9ca098e56b9a780"
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
