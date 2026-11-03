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
  version "0.5.1634-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1634-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "38b52274ceb85094bb4d72d3d530f01463beda671e3fee098d72c91675a4732b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1634-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "65de9dc7ed1e757a2182ad61979b15defe13a491c9193344b4e2ecf06427fecb"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1634-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "96b5a206e6a473ecb57110b6b5a062130a7454a1769922bc9c656b3e977c8de1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1634-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "7b2699d2b8e7d1f829d424450d04f05faa19e444e2a436d62787024f5ece321b"
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
