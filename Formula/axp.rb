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
  version "0.5.1779-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1779-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "ec893d03a7df24a9873293f1b2e15558125cd957283372bb3e7cc1f74e0be662"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1779-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "9bd1185a376a7c1e9fc080632e612c0b4cf946697b4fa782d59b0b2f50876cb1"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1779-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "77d1dfb5f93faad0527fdb0c3cdfb855c4f31191c2e75234f73053c9c73421e0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1779-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "7db7990f3ab15910a8f36396881e38d593f1535f2fdd270083fd942eaa893949"
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
