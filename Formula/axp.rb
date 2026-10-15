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
  version "0.5.1365-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1365-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "aa0f4cd9c4072bd383dbfc4074e19b2e70c657429f4d33cf9999155efdfc483e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1365-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "a868036c9b8371a53936e9b9328a9cc5e590a4658d6d35054fcc3d81a2a3c2de"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1365-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "c7c0fca711d2ac3d273b1fe15ff5322dd9b54f140168e4b2707a161084311401"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1365-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ee32bc20633acedd89219d28d7bddee24a84d9a6a276d229aa72bee73863cd9a"
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
