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
  version "0.5.1403-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1403-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "cc9eaea6f16595dac8dcf58cac8af885fbd1df8ed3a1597a9e4c03ff26d27414"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1403-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "583e7d6c02596d91e3504186330097f1ff79e6d0333c10d8d58d3ab5fef5eca4"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1403-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "1273230245c998764ccf70f1a7445873980f085b7503c8f7be02f50cc5da9aaf"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1403-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "4ce940ce9ca0b44635c6137e5954649e8b4cc01356f73bccf51f7e037e3afe18"
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
