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
  version "0.5.1668-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1668-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "6a97125196a5041874c5f36a172476c28703b59ff97cff115a535721c4b0247a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1668-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "079c5e37818d5b7e89076de9b8c95160f4ad355c7cb930133413deba5fba3505"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1668-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "6a48e4b96bde1e5c692553ac36cacf61b1f562caccc4f1aa53c30c3af3d97914"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1668-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "48cdb0221cf27f1358f539368f7e0e808b254fe8ba0efe8f227910eb5c096b7f"
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
