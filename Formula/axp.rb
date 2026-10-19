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
  version "0.5.1429-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1429-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "4a6b524349387d037d6378eb411dfecc5d9f7464ae0cb72fb187eda4a38fe8da"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1429-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "c48af6ab7f4588b0e4ead2cc2f7914c6599b9d3cf8e1dbeaf88660b2e43104ca"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1429-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "6918f1f0d3e8cb735684f88bd2483de7d3ead18d21ad4bf73e6edf5b03200066"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1429-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "420a22399cbdd08e82cb6b8757daf46121283aa7e12fcb2d0cb71d58aba61154"
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
