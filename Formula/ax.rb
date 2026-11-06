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
  version "0.5.1666-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1666-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "fcefa15be04b0da79a7aa352135f9ae3a9c37dbcc1cfa265bad24db76003829b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1666-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "34081060a39a440907dae57a5f4c15ac3f7c477c41972e7a0ab39a01e3c7963b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1666-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "39829b88477aeaec963a5918989a45fec16aa5d649c769c4afea1f314160aab0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1666-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d32fdd93f4a1aa08fd57943c65a07ac229dcc3531381fedb28831586169dfaf6"
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
