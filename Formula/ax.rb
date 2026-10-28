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
  version "0.5.1513-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1513-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "6e17c023d936c06d5c1dd2871f22cf8b0426ff7b3c5fddfc4ba77a8ddb2bc084"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1513-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "310223ac169963a4fed528cb198fe6d58805dde429a63a2c5da8dfac2ce3339a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1513-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c070fa36e457f234c2086e70b33265d220d38266a3cd619d93ba2c9a39a9f6ad"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1513-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a92ab7738eb2143fae5f2f1946548e5e58d9279798deceacbc3c4c657007d721"
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
