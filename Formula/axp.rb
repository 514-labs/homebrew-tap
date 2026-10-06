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
  version "0.5.1259-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1259-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "21fc51181d948745f669b7076f7dbbe63bbd8f9c305dbd099ff5df7e35e6d8e3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1259-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "6f294ea4673126cc9b7df573124a9605b6d182a0265b9eb0972fbd08fb47a355"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1259-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "a445e949b6ec08dd7f5bf717781db36ce33af7a56815edcc8fe86464b3b89b6b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1259-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "c297d32c4bc7d1c0dd12911e67066088769b4ccdbafceb437f570b997c83d88a"
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
