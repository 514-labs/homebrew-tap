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
  version "0.5.1533-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1533-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "ea24ebd4f9f1da448c1384300ca797d373c20c44642685f61695b97ead632764"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1533-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "e4586b96f188f6c2ca4ac36370e373b57987cd85355e42b6767d973f5c60886f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1533-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "afc865e271163018be7a2f9ef930116a10e420c1c91638055a37765f78e8e25d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1533-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "026cc8c246464b1ff991c0ae87d39177f589b22e3159a436fb1b22acbb0f2a29"
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
