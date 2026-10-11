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
  version "0.5.1324-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1324-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "032e9aea4a00c3195b23d92787131f270556c7cd98fef5fe1ab4b5c9901ea455"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1324-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "8936c9e7bfb41963a0a30887378b44c0026b9f8e3708655ec631f127fc977fca"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1324-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "966c787c606a9d3be13b8c52b49b75c4205e6173111f534069024441bbed1cf5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1324-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "81861cf09d52df08000babff7067e2abdb3005167693bd9b6c5142d0bfb9d410"
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
