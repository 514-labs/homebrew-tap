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
  version "0.5.1524-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1524-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "29efcd3f048209035d3267b7fbeaa5332ca03e7477a77c6e7ce7996c3e50cebf"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1524-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "07241c944b09064b0c5cd9dc306cb236543335e300fd6863ee59004468514736"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1524-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "d850bad28bb97b5b146fe0ee6eb23fd741d5916d68bfcbee5865d61a288e95fd"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1524-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "cef8cdc5b0fcf4fa72faf6df73eb0afcdd89c4e0e93f105e0caaf2f16b7da5bf"
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
