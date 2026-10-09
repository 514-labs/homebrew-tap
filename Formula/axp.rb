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
  version "0.5.1304-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1304-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "d3dab84bf6fc61a0456c2ea0257034bb592ad4fb993cb91ef95589bbefc6c8a1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1304-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "ab308a7afa3cd7cc40ca440b2b68abc4d4bb8b993eb4c7e899088ffceffe386f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1304-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "799baa86a42e8a8fa8c9b9504e44913e5b27b82b189077784934ad1a1b6f8acd"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1304-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "669c3e5d0678797f1821c3b289c80cadd9452bc6fd00244c881365a59a8f58d4"
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
