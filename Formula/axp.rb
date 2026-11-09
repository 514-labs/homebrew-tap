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
  version "0.5.1698-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1698-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "7da1891c6c14ac60ce8f2f5f31df1e1f2c02d246c698fa9eb8df10b93613da86"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1698-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "e7c46c79f9f5aa22ed617935dd7fe2831088ccee8902beb154c730a44a887b6a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1698-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "838b68dda7cee1860620ba20b78443e6e352228d5932384c7fb081fe363fc715"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1698-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "7ba53e179932dcfb5631e0bf5e5151767b3bb94364fabce98d1f473fa5a302b6"
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
