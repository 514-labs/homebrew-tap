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
  version "0.5.1401-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1401-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "a1d88c41e47e71bce0f204246c4452b9b8d08e66450dc44dfb17e789bd1c9e75"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1401-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "4579b7feb76f0cff6dcd126188074a700f4d437d7b605a76dee91c5ffc23d960"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1401-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "6494e1cba473eb6c84ad5850ed5bb11e7c685c3cca82ca2221cf86f99399c732"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1401-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "c4d659364d643f7c493d76250d0e4c8091610ecfb19df85810492df8e2282695"
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
