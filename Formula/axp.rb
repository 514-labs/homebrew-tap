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
  version "0.5.1636-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1636-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "443322b439860ac73d758628dade2b73b88480cb3a5da5879b3858a31ee60fa6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1636-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "ebac87c4a0b8d16182369c2bc96cc2f2162d896d7b42aa61ce4d0368f066e723"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1636-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ade4eb662e412d35332be1feb424c0346f9a4a3b7e8bd33fbff77abddc30fd37"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1636-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f2e31a7a5e55d8b81f5d55adba3144901897846b2e36805b0c642acebf585741"
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
