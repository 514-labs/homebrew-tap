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
  version "0.5.1308-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1308-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "1e6abdc66680c94e0d64bd711133bdfee7cbb217b0e0c4ebe651a9b122b3945d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1308-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "196c2da5999129196e4d16de3ecb9011c89189c224434a12704f4e08eb658967"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1308-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "5d557122107834550cd2ace35afb58932794db8de9a640293f007a3b7b2477c5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1308-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "39c144922f3ddef7a29fd0113dc634aee710611f0f7330e9126f0fb7a651b62e"
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
