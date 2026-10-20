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
  version "0.5.1432-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1432-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "08b473cc247c4ac8984a65145552053210e10bab78c6da8356df6797a8246292"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1432-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "78f8fbb3abf45b74e9d08b723bd6100efa68751390937342f325f49593d9c48e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1432-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f326c6834647a4fa3e6738b4a30500e0137144093711fad62f87376e42c82597"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1432-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "91046e873248e78cdf49d6283815b753c06ea4acef05e1d99b216535b7075252"
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
