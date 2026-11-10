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
  version "0.5.1712-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1712-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "eaa8d4bb10eed5cc651737ee95e5a30f2395bb74732b79374b92e0b2092efce7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1712-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "6e6ed5abc31302458e2f0076a5d519b10033931d6eb65886cd21d9416b15e8fe"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1712-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "47ff62a51662646c2440f0a923a26b33994b8f0f8704f10d20396e8f44453f44"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1712-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "0085019a86db46692cd7b7101fee2ba95d2aed38a0b77d6886b532ea702767dd"
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
