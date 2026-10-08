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
  version "0.5.1286-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1286-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "79d2a657e56a49f03ac4368ffe135cb7fa3af4307c3baccfb254aa08a09d03da"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1286-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "42d5e2c2ead57c402e57d9606f6dd47c8b3c76eb8b816e0e0b8e27e3984a3452"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1286-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "01bdea1071efce1732bf72f47bfd773dcf130f2d0b301c3b4ce896eff33b466f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1286-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "60e030325d3d0cbf0736116e801184ce89c92a801fa6cd7b5cfdf36224ee6895"
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
