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
  version "0.5.1689-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1689-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "f6d83dbee80d69e433b2abc0c5f72d600db8cba61bb87e64c3f5d467ac3bce71"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1689-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "c9f45937ec0740c8e1dd8b65e7ac00106fc9254fa33b97b5887db77c8e3a75b7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1689-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "986d42c8740e7578eb94a43becd41ca09610ed932b1cc9f550fb55289566e678"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1689-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "565b96ec77c2f8831b29ef73b59d2bd6c206e15afa1cfcd48a790e4015f984bc"
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
