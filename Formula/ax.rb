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
  version "0.5.1312-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1312-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "91869ee5ffa2063696caa9d752670746c423766e53f0e41fa601fb6979cf385a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1312-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "2fbae124d4400a1a6bbeb19e3e13f8380ae46f9adcbe66ebf39aa0452e0d89e3"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1312-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b850aaf4b7737647f6de6cbb9564654fb054c03bda77ca947de1197e7d25650a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1312-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "90627c70a59d929e9a68cb83072072c2b7581341be7e8232c56c4349a0875bb3"
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
