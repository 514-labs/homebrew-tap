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
  version "0.5.1777-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1777-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "0e5f9b02d19be7e86d9e3429dd59c17e57c83859502b5672a3b249868bff9b33"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1777-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "2bfbcf9a5e8c667eb60fc932debdc56aba13de60c02db32ec9f48f144ea90e20"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1777-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b66bd9e58ce2e066c6f9511b3a787d46d9680b1978a6a29da81108341946e415"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1777-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "24545871bc5a85926800cd3600a152ae7d0e7ce03ec8e79d844fae4d9c53ffb5"
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
