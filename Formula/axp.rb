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
  version "0.5.1336-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1336-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "8c1a5eb3a640b9d07090c46099bf16a4af4ba1e08a3f828e32adba9792e6d48b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1336-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "fa1dc59a98ebbb2dbfc2ee3d38c2ca6c654c06270fd00d467be4ed031b12a910"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1336-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "e222b950506ecad1c8775cc80482ca9abc8cae19fcfde12989e1a7bfe9268617"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1336-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "2746179f4cf08cf53fda76f9b9e6f471b6bf1825aed167c3b03a431b4562e80b"
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
