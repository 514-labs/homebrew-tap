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
  version "0.5.1475-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1475-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "ca0c587eb7a67628540d6a06fae19a056582da19995bba5e7253bcf8f2416946"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1475-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "2c72f0f6625cb7d88dcedc1036e26e6be59e1ff98024c0310ebfb7f250144a8b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1475-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "984f56d0ed17fab110129df8b6f1f2ff5ce36c4a030ef8a96d173aa5e354e873"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1475-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "2740085a361a69c214a682c9b1d4036d26f25a078c2d48c0819140d5d28bc48c"
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
