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
  version "0.5.1784-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1784-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "31d34242403e1477f38dbbe3e78a7560e475304c56458ecd1373c132845e72ff"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1784-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "c415ab5b95361e8e0603db7a1410fcde84d4fb1176df7a8f113ad45b8b12d117"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1784-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ffe1bfde2af714aa3e4c7b37fe78e0c947e5bd558009db67c0d70b4dbfbfe3f1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1784-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "61dd49c5d2d675ec2f30402da4f31bffe67115b706f51706b8c64104f2f9ed8f"
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
