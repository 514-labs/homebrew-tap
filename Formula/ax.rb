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
  version "0.5.1310-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1310-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "9ea9cf0b478419580345753a256e97eb9056287edf5f0809697331a81fcb4a49"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1310-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "9573a38ab617d9f0eda231dc53db442202364b5ac86be4024ad8d296f009f271"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1310-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "145965ad2d4771e16b8aaf0693d3997817996e0d7549c5e14ab3c5b8dbeabb9e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1310-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3e3e15ef58ba3edef5ad1469fdaff90e70bc7f20c930d0b854c59868ca2ca01d"
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
