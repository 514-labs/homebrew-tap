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
  version "0.5.1711-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1711-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "4d40e8bd60064046ca515ff1c266d52db2253e6bf3a3763fe18a83890c1fc721"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1711-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "445a51c346b1390a93c10a89b5b449e97fc7d8281b81f776ad0232526f063ac9"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1711-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f8133ab81a355533a03b5a3b6038c3da902f48b12a006c14d502bf6b620ad932"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1711-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "12e1f1aa5d9b3985893b8304fd9ac3b1f6c99617111d282077eec0a48c8b37ac"
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
