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
  version "0.5.1691-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1691-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "14931aebdbcb51adcb71af8696a5db0a267af9de783fb767ae22a01e35bdadcb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1691-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "01212553b64494ce8f16361988c66f7562e031a28642e0e726b3efab53cf64ee"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1691-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "8ea07d2caffb252f091d6d730371d932117e9bef7827afbc069c8586a592dfb8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1691-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b4e12d0623274d2a40f3963b00fd9be5a9fca55ad981ac5a174e5906bb2ac5a0"
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
