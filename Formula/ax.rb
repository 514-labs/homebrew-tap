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
  version "0.5.1330-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1330-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "5d92a02ddc999c694f1772b7eb14f1cb6314674f68892f2afb43df6fc271348c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1330-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "bed5b5ff7223c4b35a9164e78418d197be24085cc90ba681ba74046b780ac32b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1330-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0412ddd44bfcd79638ccecc0892caa3ead5b2b4734669d6fa3a2f59a13ddc104"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1330-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d7d4351f093c0649c23f8b5133645388809f142a04568422eb97ff4af5993ef1"
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
