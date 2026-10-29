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
  version "0.5.1534-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1534-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "a9f1f6e2ef203f08c71df59301bb533eec4512e4544e50e772bd2bbd02292f0c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1534-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "395733d62f0b9f6abbc53c4cc40a7e98dcbac5bfbd47dce6172cf4fda33e426b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1534-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1e6a1d5d824d3099fac55cdaf7044372e792ac680260afbe7dc7ce89648d62f8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1534-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8396c623d62308c16811ea6f84867ada04073ef1a67638e22b088cd1eaa8c596"
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
