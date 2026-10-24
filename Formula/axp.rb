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
  version "0.5.1489-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1489-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "b0a816188784f2b6cc28a3a70c1ff7aaa210dc7e88854b8ca5d04b77d0832416"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1489-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "7371d4c6a58d741d7bd8056b771b37bb7c062a274e0075f6083c8b5394174c7a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1489-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "c18725d4a62b42c4f021bc7775075c8405533e4d468c4ae5668dcc8b228a4db6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1489-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "d837c5d550b36ae5b7b57ff713a29b1af6c603e09bb5b597fa7aeb8e65a60115"
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
