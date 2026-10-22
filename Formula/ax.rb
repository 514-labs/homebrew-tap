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
  version "0.5.1454-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1454-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "053c20fea5c664fd6084b5891700fe2eb4b812d5df2e8492b1a538c51e356b9c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1454-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "4f5c4d3435a20900eb3b469252427da24c2a4a939e690a4a2390c962eac11151"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1454-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1230c672a04728afcee0665bddb57f87980ec7a65a3188ce127541090922720e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1454-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8a7f2c9a3b80add76004e600a524ab4a9b7425d57f7e069129ec6e285bcbf37b"
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
