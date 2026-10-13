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
  version "0.5.1341-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1341-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "7ecc285b190770b22e619a1ca4646567c24bbf51ea70d4da1fbf338c6ffe2a82"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1341-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "3bb2232372c9d28724a956fd0cdf5b22468f3316bf6d3e589eb288eb81201f1e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1341-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "0acbad003c714d8d7707f58b43cdca02ff6a832b0fef493c9acc9a6101aa66e7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1341-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "02dde7ec3be2ab3637bfbb0929325bf5ef4b5bb3ff4ecef56b05ba7064370e41"
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
