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
  version "0.5.1342-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1342-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "1abbff9c25a4360295320a6d76c99ccb8b1aa88e7ad567386ef5bc6479a96042"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1342-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "583de7839dd4079b8c6fb2751306649821e94cc7773c03aa7976d81fbd4ac149"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1342-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "d580ea978ee6cf2b68decf85124a553c9106f19c9fc371e03dd8ae6557ac4be6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1342-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "347bfda2147479cfdc4de0d76548d4d7cb7e239481986cf3b461d60639735fbd"
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
