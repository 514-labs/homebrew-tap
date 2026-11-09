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
  version "0.5.1699-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1699-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "17d104e05bfe7e8856505bd0dbc21b300b5fcab66f2292709b6b92f7cebf1da4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1699-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "bcd669bb49b5a5d789451b1d0ace1809cfe425c7a4bafd9cdf0909cf81c9b380"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1699-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "7030b0f2141c29774c1734b7e352763b548931e3c11cd8112409fb96ae4e0ee8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1699-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "3208795f4aaeb25542381a2896386171ab92628116dbb55cf24505b8dd3e039f"
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
