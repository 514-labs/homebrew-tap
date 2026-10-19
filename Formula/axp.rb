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
  version "0.5.1418-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1418-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "25d340bfee289c969fbabc04d5d86480487a804f4bdf0342faf1bf8c57d70fc1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1418-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "9b9d5edd46a2cbedc3fca7a164d537b86e664a44cc5fa80689ac51c80c23eb7b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1418-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "cb4f51332a4a26c313080895a37cb6bfb7ab079f529173b411d58d8ff78b4a64"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1418-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "2d7c247f906d3f19935ad0e0f3be59decb51e0dc779e6cb0259c81df47fa4336"
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
