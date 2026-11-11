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
  version "0.5.1718-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1718-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "d4c829d594c974f7950a70239b4871e748167d6ea36480b94c3ef1f1e5648c01"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1718-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "3de0e495456d9877d0bfc5a7bc90e4ea716b0fbf2d303a504bb56d4b7485a06f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1718-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "e1013d57d9e78d3b4f57219f9caa03b62161a2619d9c9ff35ccd998b9142bf67"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1718-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "24f5dd007e4bcc815068f83a4347125c41c40df1ac22fdb0fb7ac49d8b6d7f37"
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
