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
  version "0.5.1764-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1764-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "9668f9afd196bcdab5e6399cb9a2bab0d5173fa5f4536dc3734a97df3afb765c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1764-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a5cbc6dbfdfdc24b04cdece8767b0829a6d97c61fb1ded806f79c22439b6ca90"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1764-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e94d26904843d6b89e88e6d213fb717be2c6f45d2c0170a1ecc42d1d35e5ba5b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1764-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "171f7c4eead235e8268fa946985fc1a0e7731d1770d11bc292448908dccd775d"
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
