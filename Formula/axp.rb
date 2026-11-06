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
  version "0.5.1655-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1655-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "77a7cf64bf8bf6dff05c50c1aa48c4bbb3c1b43f6a263bbf6d800b7ad5ec9c80"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1655-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "5c9f48e91ac50a2d6395fb20236ab61881a1cc9676b58972c689e78764572d31"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1655-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "00ab644ef4c87b9e137512d5220097ff24f0dfdcec8d01173ef58dc0bbcc3dab"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1655-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "2515bf543cfb3daf1e369a672bba75faec6ad3f668702ecf82d8dc8e6904d5a1"
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
