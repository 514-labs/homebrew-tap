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
  version "0.5.1695-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1695-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "80e6c02f6bd8b80b2de00ec0fca5fecb7ef036eeebc119c36d0ee79a4c2ce985"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1695-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "69d0f01cb1fa7157573464c9146944251d8ef1abfe2d051af97d40064ba78a76"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1695-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "63ff55fa15e6b52e3cc04e6f81b92e48ff1ce0c8c5de6dd813e471b88b8b61a6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1695-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "356bf76b0f90a5acbbe785956ff11f81b35545ba7113ea375373df2ba2d82611"
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
