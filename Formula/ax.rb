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
  version "0.5.1437-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1437-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "17474a7d0950c98f544972fc865b0c66f900c53c2386b09e0e9f8042e555b919"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1437-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "89b94eb5f48fbf1888125a08a51cee66602f179a938d666135dbb377263b7363"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1437-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0ae4ba6a67cdddbaf2454b29c4da124201c6686dc68680da40d61bd29f0ca58f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1437-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "7b88dffac5aac3178182e3033c44fe4cb45d07cab134fd991de60b1813e7fe7f"
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
