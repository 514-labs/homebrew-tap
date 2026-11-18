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
  version "0.5.1754-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1754-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "6a27d341d76117a077c286608a8912305a4b0c5dcd9c5dff815a431d1caf2e04"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1754-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "261fe27a47eb203f51c71b6b005efa6985b850149bf10bf45369dce239955714"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1754-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8459f0298f1d7bc1be41e967ef5a51c70464f58f69129ad9a5e3d3ee82c47c4c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1754-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "80c72c7868da7f33d915a977cda5b5ffbfc7ad73c08551b8431c6a1fbd14e74c"
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
