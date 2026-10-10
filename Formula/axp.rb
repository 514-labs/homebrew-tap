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
  version "0.5.1315-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1315-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "285f3bd8bc299b0a0b217f80f298744a687cf452d9fffa957695a073629bfb64"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1315-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "7c6921da755bc990f42f332c6b173fe83d987b08f10f064d58cabefa22299dca"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1315-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "473f822785ccd09bddc80d62219901bf7494de71e1e58fbdb4a379cb8f60f15f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1315-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "48005f36df04041b80a6063aa3f34b8c0f6575fb5c12017e6fa2d9aee81ae38b"
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
