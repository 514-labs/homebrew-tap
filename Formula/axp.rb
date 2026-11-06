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
  version "0.5.1658-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1658-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "5556d0aaf13fdc6d2e51f89a2023ec9d04cb85b076b9be4bfd55eba650230609"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1658-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "0f8217e4e975f503fbddc34a9d5f8aa022b134c5212454569efbf1f0e7027f7d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1658-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "089f83313b5e62e385d83adb3ad4611d9a79ba345f5533ea6dff6dd24452601d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1658-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "43101488691135163f78365d5adcfadcc9288c6804f06f7320367210718670e7"
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
