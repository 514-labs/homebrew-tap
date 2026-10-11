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
  version "0.5.1324-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1324-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "aa5efc2da0577018074097cc6cb6b6a675656908d1ee53732b721c44124b1ede"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1324-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "ac48751d78455e931dddf1450fdc986c7a7be76c5270b2b44b9affb4f0cd05fc"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1324-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ae17c4b7b98dad981a4bddaec6f0a7b4423d4c0294c76e05ba168ecb646f1b6e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1324-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "aaed9f05dbab8dfae2a2a66eab398fdc2ad3c7faf3657921af85258e8dfdb73f"
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
