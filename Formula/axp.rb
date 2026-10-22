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
  version "0.5.1467-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1467-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "b3155076641bdf595504ee715db2d489d2556f5446fbdbb6ed6a0c020e3af088"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1467-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "e60493810286bb095ce46d35cc034ab2cab0f5b365450d1dc7537b05263e39ce"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1467-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "af9c46d22cee19b347106f1d0ce3e6eb84cf888f31dcf72ed3fcdc11c9076d9f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1467-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "4bf3ff996b0bc0f9d8f423401bc8c045e3a097387332dd9b7295bebd2c410283"
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
