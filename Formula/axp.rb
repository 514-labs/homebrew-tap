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
  version "0.5.1419-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1419-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "ce135c1c42d00a71dfa20c69ab4c8382da1aa3180978ef9de699abd6bd3713f5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1419-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "21a4e441f670739c4969f54a240ef8347a98a1d6cc40c4e55c854b893482a675"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1419-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "9e89a882df7076d9c1543ae746df1dfb90974b152512c21c52be5519cf6934db"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1419-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "9666e5e034cc59167d2ac58323712ddbe1b62ca7310a6ad97970403872a7c9bb"
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
