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
  version "0.5.1510-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1510-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "c08a0e570b49cb208a806d7ad627e80f61b99019286c3016a3b92d60b6494b3f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1510-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "52dfd10f05ca32e54a9539f59998b37570c50786e22c38294cb7c97709171c1d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1510-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "430458cf934029d4641abb6bfb356de90b842f88325b3bdae307380f430827ec"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1510-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "5c5756be9126f74c31df7d433311e22db1e6181c883ba2de05093f61bd98fa42"
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
