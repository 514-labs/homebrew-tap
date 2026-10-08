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
  version "0.5.1293-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1293-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "c9645061445907fa21015cecfbd51f86a741c2dbda49505f4b713c345ac0e46e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1293-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "e689d6d7cd3d64b138f8ab3a53dc20091d7bcee1f079ab00e7d658abb66a71e8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1293-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "6a2e150db8657fe8273a8e595c1eb7d49210f4c823af15719ed86e42054e62c5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1293-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "8c6dffd10e31bdabf225db7ea2af538f22f4765713464a74f1ec8d3b44e01a71"
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
