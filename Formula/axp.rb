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
  version "0.5.1542-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1542-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "da8a4a4cde626705b43ab50650880b1c8eeeaed0d41f09997829673b81b83068"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1542-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "f30cc1407c03cf9acb70158573783f4fd537fe4022c1097fbbd11a64a1679047"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1542-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "74508dfa8c29b801ef91068545deaa641870276bca3041c9dd2789e572cf3dc5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1542-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f53701d864fbc1156bb085f32b05f66242a9ef360530cf1c162bc3232dde3b0f"
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
