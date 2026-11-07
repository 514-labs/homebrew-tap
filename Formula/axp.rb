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
  version "0.5.1677-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1677-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "c435d1014807a445582285f25aef421ea6b0dea092507b3d4c67f9e3215a806c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1677-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "188758ba68708ff967fe7659b25a03218cc00eb4fa59690ce26d0a14aba32644"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1677-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "de6d8c300f3d7881079446f2c9d9f3d24ce87851b9f82329850a4aee186aaec4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1677-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "30e87d89dbb340cb4de23cc6761cfd4366e38d777dc17f3405cc87d5e5be2649"
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
