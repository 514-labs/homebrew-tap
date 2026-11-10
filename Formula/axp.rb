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
  version "0.5.1716-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1716-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "528bed0ce8239311ed38add5a9cf7e5891b8cdd031df1b020864633d33e226e8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1716-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "3cba63935ecc3aa9a77b634d4f09a3c69b07aafdc282623e9e1f1596b0b38bca"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1716-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "836300ba819af5e85acdbfb6bf2a9e062cd437fbb3184465771338fb4cfba0f4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1716-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "e22cd8d19b9fd273518ea740df95bbc9b0c50aad441a673cc01770869a3d5b73"
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
