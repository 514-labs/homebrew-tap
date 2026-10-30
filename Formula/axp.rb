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
  version "0.5.1545-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1545-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "b0f3ff90fe7c60bb0d7a2e1ca75a4f31af6f9eda9f4dd7baf13a9beed5d04c4b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1545-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "be5ec08058ce9af81fa672e3afc45e3db65b19e7b46199d2742e7ddd169071c9"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1545-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "48aef76e21425b25805682132b1e7099f21245da1dafef007fa7bfa01bf2f0bf"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1545-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "3b8ca16d1709face459bcdc3fb134a42f210ba74a1358882763afe4d2b9ffcaf"
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
