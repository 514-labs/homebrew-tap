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
  version "0.5.1455-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1455-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "6c40f42d16428e1bc98322900735c02eb097cf582d07072f9a45b324c49c0923"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1455-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "f8cbc5f5d1e0fe87a4bae331e4282e0bc0fc287b51feb38c7088f7cd58c382af"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1455-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "aa28f203751cd2e0f7fed2e195439bc99555d8d496ea4cab9d8c80bdd19fa958"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1455-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "cb65005e997486ac0abff40f925e6a07da7e9f95e97e926fe7d78777a69711e3"
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
