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
  version "0.5.1261-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1261-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "bcea93382350f50f02a01ca1f33641cefe5bcb064ef02bcb64a419a321243297"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1261-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "7aee0d82486e89393473e31622d92b1e67187427b541a7f27adb89ec912d0778"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1261-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "d0c7f04924a55cde6ea87212c3eb2fc3aa8d56b1e02307e726c6b9591d2d467a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1261-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "1752530633741edf60d507bfe52691b1729388d29fb858359fd12f1e4a06da61"
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
