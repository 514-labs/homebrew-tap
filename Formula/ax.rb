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
  version "0.5.1719-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1719-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "dee2ba62b5fd0f7033a674700500416f68f1258af990a40e969157a32f3f05a2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1719-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "215ddeac18c646e20a0cdd0d4e13b243f76266049038a52d1f69da5c225579c0"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1719-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6e38bfd8bcabdd7f472e2b26bdbee987a5cdbd121310d4bc0a7242fa5a37fab1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1719-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3536cd7eb24240e2d005e7b4f668276a098906897c272a77373a3936c8a7aede"
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
