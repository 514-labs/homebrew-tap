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
  version "0.5.1269-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1269-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "f605b4eec254677813abe78920e4db595f5382cf64968e67cae2cdfd6f227272"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1269-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "c9eb0cd35f67d5b0319d8a94e0d20773595551e6bb82d8b3031bdec48803864d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1269-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "0f1e08a74dc9636735468cbdb6c452e6b1846181df2edaf9488e8da83f759aa0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1269-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b2055883a044ab56b0c1376a271f4d883f693926e8f05f5cf1499adeb47e6389"
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
