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
  version "0.5.1735-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1735-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "273c34bfd107daeee2b57eeba0d5ceb49bf14ef8c2177dfdbc5d82f6e2b35d50"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1735-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "5e8b907c082a32f4d9e774730f90495a7f71de45acac67294243df350dc2f44d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1735-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "058c1f457467f3b8aefe27fcecc42767e0726c92984ce76c3856a92d03b774ea"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1735-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "8f2aae9a83fefd70405e74e9ad2a2e0cdd98f23332ab7e94c2d1903022397df3"
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
