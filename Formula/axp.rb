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
  version "0.5.1566-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1566-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "2efaca0ef13c4d824abc7051a6751fa1f1837b322d3dc05c21f077bdf9dc43bc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1566-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "9655d3705258ab02ac4bb60926cff282c27134c710eac52ca0f189161efa56f0"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1566-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f2ff7961cc687f1ba67460ad13fe776fd84e20c22d01ba9d64f996bf484867a7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1566-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "6233bcd5a864239e0e77e1846842664f80cb80f03439a8e3c07d7f655c0b7f5d"
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
