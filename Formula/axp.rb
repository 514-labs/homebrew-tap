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
  version "0.5.1326-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1326-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "0049481639b81a5849ade77584dfa69937758d93040bdfd4970b1379b9e124c4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1326-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "45fe70bbd80011d4d0fbaec4601688d58f68ac228d0fafbffa5fba28ae445fdf"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1326-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b584d8c00316e8057fd4c229586f7bd3f5be9421d57f6ece854d4de6b9c1daf5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1326-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "c9d9acca3a7b317231238de21861dac878b574ffbfeca0aa28ed817c9c85d136"
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
