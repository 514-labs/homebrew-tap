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
  version "0.5.1483-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1483-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "d0407f39b03f33650245fae6ef4c537d22b36de38da9ac8daadb1cb856f202fb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1483-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "7e52bb671728fa52872858e9481807844020e50b9a77713529f32a8309392cfc"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1483-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "db5f9e6ac8c0a6fabac37be1291f97024156d4dc96a77d096fb8856e13ca498e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1483-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "a4e811b7b6209ca730210e884ba9416676aab522a1ff30a410550350e28b6dae"
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
