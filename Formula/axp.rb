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
  version "0.5.1526-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1526-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "a62dce7024d0fda5f6a510ae5f5ff34d6cf15ba7277a18e7ad2600c7f28a2bfb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1526-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "afa35fd10e9127a5aa31d68be6ed7f36f8acb8e2694921020fb9629b528c587f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1526-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "7d5cc9179dc21158969fd4ac841346bdaa3b756cc57dad93345497b020cb6cae"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1526-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "172704c91bc6de0b7238541646b72bd571e396e0cc6c885ba03864f9d9477e3d"
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
