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
  version "0.5.1488-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1488-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "160691c4c7ffd24aadc41aa422c0c609b3266effb30c061c65a0faa99bc0b7eb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1488-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "c4e3667a5f4a795decda1247d336174c3eb077bfa831fcea8d01b5c96a19be83"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1488-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "22551cfe8969c74088c0808ef77ab6791486dcdb5372bd07de51c9d5ab515cc8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1488-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "026b1e1c219a3865590d2f30c759cf1e0112af2ebf44ea309caf69cf85a202bc"
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
