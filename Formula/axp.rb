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
  version "0.5.1348-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1348-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "634a2462835c81fd30fccc04349c026560e9b9e6bdd452551944bacd40c55b2c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1348-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "bd8d69f41f265faa8e9a1b06847eacf77ce94cdcc5a9adf71050dc908d355097"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1348-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "d906d58b2bf3e519141a76dafdc05700011a0f1a91f206851968feaf0bf30ac0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1348-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b859f29c4b252cd7548e8ae4ded24462637be451f35f3f92fe36312d9d8253b4"
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
