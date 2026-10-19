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
  version "0.5.1423-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1423-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "f9999f30354b9b7554c6e5649688bb873da513ce6198a56ad0c0bfa9744e60ce"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1423-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "8d9e38bc655d2673046b72a169e29a1d6ab74704a2e10b079e08d05211d1b9a8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1423-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "2a810b84573f732a25552f0802515e76769ad70dba13f3a89192ddf8aca68db7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1423-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "55fd7e81c35b885c09f4eba85df1f0cc81e39d8f215f9cfe05e3dbb975184132"
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
