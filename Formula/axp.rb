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
  version "0.5.1305-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1305-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "2c3f19bb60fb1c0a0a3411e20672abaec640529e1c68bdb3bfdde355ffb681e4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1305-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "01fa25bd583b0e30f852717c864aa249561d95ab1dca02c6147e83bb328296f8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1305-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "2417781b0ac6245422dde251201dc3ab48a4c100aa60e49b4659a5e04ea65ee9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1305-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "7debe0f6c140e08baf55e8c11f90a5b5b56e637aec5932ce8aafb4ae81b8dbaa"
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
