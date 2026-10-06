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
  version "0.5.1256-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1256-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "0746410c9791b8eeee3e5cbd509849d3393c34974500a95fc39303ec30c06a42"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1256-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "57030b68f088da7a7b422eae6935badf1f7e5afe990ffc913eacce7a540838e0"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1256-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b040f46f5b4c46cc5824654a6bf637557d1dbbe400a9ee8510a8ea32fe410a8f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1256-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "2ae79dbf0b12605ba582d26f588282115917ef7b83100af19ec99f9fe9e5a052"
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
