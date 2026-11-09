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
  version "0.5.1693-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1693-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "2f4d64185dcb5bfc04915ce65b7407081c8491909ebd19c4ff6ce2efeed86fcb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1693-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "b432e8465937ccdf7a6a9840a5b00ac23022c045c5090c82def3ffdc778133a6"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1693-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "d3a1ba21599ba8c2aa0017d543924ce9e771bcc16cdc2ca2799436fbdb5e092e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1693-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "29b43c154b41490ed777899e2068cca0a30f6ccc6e761f57110208a6d57b7775"
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
