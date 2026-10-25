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
  version "0.5.1492-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1492-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "c1e2e71db9c81622b263d534ad8aa8ef2a0d14657fd579047c813f647deae875"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1492-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "d74c638b82551a5be21651002cb7c965003dcd2f5cb4b0b5b37bd6ce19422a6b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1492-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "1fd45f825c6b60322eb0500b5147329ebb1df303080363acc91d982c23310d8f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1492-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ff173b2679b7fa7438ae2405289ad4e0e94f11daa7790eabe76017ed2d217c27"
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
