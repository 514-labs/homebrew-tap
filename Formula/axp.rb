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
  version "0.5.1254-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1254-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "805671fd36d832271d0e3a4fb9cf68ea0bbc53926e01f5dee8bb5b84c1f52e57"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1254-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "2b8e6f8bfdc3838e088af6e05d3b9f9b094977156b7dfed8ca63ab0604837838"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1254-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f4752047c20c2037b838e0cc906b4cefe17870f7db2355b9f6bf32ef4322ffad"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1254-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "e7637da003ffcbafbd63aaf5c76630f7e53c3a910926192924fb01f5bcc27279"
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
