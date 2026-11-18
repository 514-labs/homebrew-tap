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
  version "0.5.1755-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1755-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "c24cd9ff8b48a4a175426421d82f3cb45e21a2036c037b74237278ae6a8eb68f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1755-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "db10ec8547f6d06ebb4f1025923cca43915e2033e0b65885ced1a38569f68ffa"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1755-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "86fe8f121ad3db7315fc20a61c0659a1a3cd04f7f02d2048722bbb6a5823d0fc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1755-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f4255f17f7fe7a8e6c21b16972aa76505d0e348ff2b1dfc57cc2f8bb8c734082"
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
