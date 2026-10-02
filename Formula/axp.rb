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
  version "0.5.1237-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1237-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "44ede6ce6f80ff09af94efa3279218a7fc3a00f5b39d4cc1163110a08398a8a4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1237-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "9a7414c3813b8c3cc64cd2e7a6032037cd8dcec3d94eb47cac3f7857db5f6b0d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1237-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "569c51c099227a2948bb7a124a2882e870258e9e8672630008147bb40c9ee5e7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1237-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f682cfbf4f0e782bb08732cd9a101fbb89b40ae680284413d09a3cd5fd6ede17"
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
