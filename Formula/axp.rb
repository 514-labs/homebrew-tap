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
  version "0.5.1679-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1679-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "79f8ee529a851e72dc833c23e4d3de0d77d44cbfe33cad274f4346e7c8b752c6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1679-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "7ccd6176ac4a2dac7588135440f3b453d92e6de4de8dbf9b5b2fa41eb7272233"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1679-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "65e876ee1ca0040042f32554580afa9ec78afe9d982a95817eb60b42bb705696"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1679-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "1659432a270dfa592d5fe35bcd136e0f4efefb62d16ee953adccbd8eb83c03a0"
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
