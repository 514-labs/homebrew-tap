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
  version "0.5.1798-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1798-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "67c5d4b97d67b1e73495d6fece9738b8fa5d8eceac6737d86da28009f82f8b49"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1798-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "b817fabf1c6b74cce55c55a3061e7ad44c1e2d86ce2337fe3757b242933d835c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1798-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ffe0ed0feca92c0c4f65a71c606fe8c66d4ae4753e5e3a9ead3cbd6c7a4989e3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1798-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "1e091dd46da661f59740813d0925bb209a4d8ef273e34e47d29885187bfab6ea"
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
