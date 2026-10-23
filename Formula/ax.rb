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
  version "0.5.1482-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1482-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "9a5c414c01675f66977cb2b45a18d5049cf1667bf778d192a900b39255ea4958"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1482-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "4fc3d3c42e3b571b78063fb7d48d20a9ff6b716893f2cfb3ffb9fbe5df2f181d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1482-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "7f6e93b73b24bcab4131b5bf45f63c5f5897ca226f6ea78ecfe05fb2a026e038"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1482-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "40a5d6c4870dafa16c68683e78514282ffdecc19fd9283bd1eeb82d2db5c18ee"
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
