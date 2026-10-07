# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `ax` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
class Ax < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.1267-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1267-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "f166fba35d92f4510cfa9773aa18eb5bbe339d071116fb76fdf59c893dc0d9ca"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1267-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "19d20e3f196b189842e083a662a94c67c038feb6022bd0fe09bb293b722005fd"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1267-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "327c06b7e5ea686b98ff410c5815c567785eaaa34667ec8aa0e4903722fe5680"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1267-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1bbe4dfb0a14d6afd7c3006d7d94d541719cf12a6eca6719db02a18b8a4260a2"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch archive
    # (`ax.tar.gz`), whose only member is the `ax` executable.
    bin.install "ax"
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
    # Keep the smoke test hermetic — `ax --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/ax --version")
  end
end
