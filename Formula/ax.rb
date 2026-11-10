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
  version "0.5.1716-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1716-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "6503461888650bd53b9f02c20b69ea86aa164ab9949d06801d6f1311b2b3552f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1716-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "d5dbc5ca5111b035a2b6a9636575188145214f6408762363c8a185a0dd7fa0d6"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1716-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "200debbe72ec84c7be07a2da478966f7b21df572826c411b4c53b62744898c3f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1716-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "99b6ab9275e9ef05f175bb6069d5aee05554b94f3d35ca61272af2a93351ad35"
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
