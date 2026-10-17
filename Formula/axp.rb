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
  version "0.5.1402-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1402-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "a64cf6bb8e346507c0152113c99cd4328c39856680060c45b382b6f89d6374ec"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1402-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "c21d1cf094c6a6d32ab7f6bfb4334095a70c2e2632ba1890984330078cba540b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1402-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "5d32e4a5c65b5afb4336ed68a716f534218e4ae076d120d92a5d0e8f473d0925"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1402-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f1d1a1e2eb769a727d6a09ad1ba254ce8488883e4ed7b474da9f691632d42946"
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
