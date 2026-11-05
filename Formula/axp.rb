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
  version "0.5.1643-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1643-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "060226c47477734915f9a7866ef1461e1d27f9377e20cb926e68b31850e89cdd"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1643-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "5d742c7430670c1973a3036c923687365ae4284b1b3d8801731ed5a7230f1aa5"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1643-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "36a93dd1741144d77516546622587e611560f40518b4468570361c10e359f27b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1643-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "e1382b3f1e70ea25c2b87b80faf6beabf0b8d4acceb9a71ba3b50b2787c61c92"
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
