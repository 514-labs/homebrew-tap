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
  version "0.5.1387-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1387-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "ef4e78e1a34e1559e0587dd31db9fc5f647868eca8b652f551be98f132ab80ca"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1387-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f230ab02ef43585629beef153bb8172056f673273017a0fbcc47ddfa5f1393fe"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1387-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ef84735cea78efed4f31aa685eab407fa0d1d2be224ee562c28300d4a79627d2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1387-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f8a0de49d7604ee76069b478dd856aa65a256a560b62bf14c4b56605ea2382cd"
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
