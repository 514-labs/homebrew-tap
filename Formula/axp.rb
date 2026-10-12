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
  version "0.5.1332-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1332-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "11790d9ecf2610adea16de0c75b7d66af659f8e85296279fb492daff46bd6080"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1332-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "fe108c82df9f02df39bb8485bf870f70cb96914f1e1c2c021ad934d28663ec06"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1332-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "1bd4a7210f7086e21fb3e49ca313d460693e21196c17ad78416313cce5aa526f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1332-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f2e7babf5870682ab40dd9a2cd1ac2bc3d64ab40f004e7e84f653059b84cb73b"
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
