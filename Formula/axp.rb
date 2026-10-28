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
  version "0.5.1514-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1514-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "4e47f9f1001a4e5bddf5003e9eee2f16965e8991a6fedf68178663911252fbca"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1514-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "a6dc585199bb76e8be564a971f5b06bf53bb9ce61e206c46b8c90515b2135cc8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1514-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "20c11b3e4bf716be91bd11c3299ac9e91361c1c0aca57b51921647240a1bdc7c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1514-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "31f7f9059ad4476aa205458239459bac01832db2b33f6bff410be1d0d09f9364"
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
