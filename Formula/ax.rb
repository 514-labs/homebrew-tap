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
  version "0.5.1300-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1300-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "e421fa6a4483f4b252fdee9c89bf64bedafd0877915902710c2e70be71ea9489"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1300-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "c9ecd6d0708526af082c5625d2999769da8691a9c47c94efcbe34923e6e805c0"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1300-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d84492fd3fad96d776e83a4e03a4c6a6834906c1d711f5af689c786738bd013e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1300-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "670c0e5e319f20f16d8e80a288638d6908622c17e666e45bafdcc043cdbd7683"
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
