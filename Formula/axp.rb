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
  version "0.5.1675-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1675-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "d2276090a7ae4c39c4b3386d1b550065845fd71fc969855bc791f4833d099efc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1675-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "ba3edd3e81dc41f816e7a02e08d7dac6f64c451ea2fb4d8ff7c719843d843182"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1675-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "cd83d6a5dd93ff365f65eacf8b8868691c4ca0ed8bd921695f3cb5150d24b90e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1675-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "8a614731d925be554ceb8f85b52204eee211796b67dfbefd0b65e49d8c29f795"
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
