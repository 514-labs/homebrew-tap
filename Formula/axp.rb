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
  version "0.5.1661-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1661-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "ca94192f56efccadd9e1ee63f27ae7d28e6639eaa9e51009bb8fe22bccb07ede"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1661-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "608d2e21982c70f9c8b239888e28372fbcd4a65d388731337a3f0f9317d1fd31"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1661-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "d2aae36ec0d2ab61b98525968f1d61532e0d91df3f3291ec9bd6e0ae59604982"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1661-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "397fd708c3064f2b7fbfadeac618eb13af61a27d1d33b81ed2b82351314747cc"
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
