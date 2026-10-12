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
  version "0.5.1331-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1331-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "10e1f2d65f9347a728b06c125f86a2a8d9f5f604b15b210e7fd8976b83fa582a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1331-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "567cd4f32456d12ad6ffee357d99271800615abaf109cfc9e8d971d733759553"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1331-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "e4da5123d6452a9347e6a1eff7a30a15d7dff2bd8db3a41af2faa8ebd9a5ac9b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1331-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "efc2d729b7475b82d4314c6931d48350dff366809760719ae7784965eba84c96"
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
