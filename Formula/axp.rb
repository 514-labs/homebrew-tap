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
  version "0.5.1513-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1513-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "5523f33ac0c779616386c4f8d208c77810340e3909530810f8d9097a4470de72"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1513-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "da963429c724342fc27310b953d0951da5f2b54115be785859a26483038fa03a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1513-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "a803dcaec51443819bc6675df1bb1d1e52a23e95e5ec531ee3b8838865998114"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1513-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "658af072f8691aab5faec7ae0cc9dfa217e3d29d1708963706cffddc3a5726e7"
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
