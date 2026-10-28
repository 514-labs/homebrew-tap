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
  version "0.5.1517-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1517-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "01c3b90d750aea5c7a6a8af88da9cad2fb896981c534e225222449ca58da6471"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1517-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "01e07a673282bf788a881ccfb6478d33355b25dabac27af44f3a57ce06f877cb"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1517-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "d22aafec512f137c7ded09bb27455a17fb9561b0f18d0fc940173a89f76eb8b7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1517-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "fcfff18f7bc93b8d71c7af04180c77d15ff00b952c21a70f8d66cf49de0891c5"
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
