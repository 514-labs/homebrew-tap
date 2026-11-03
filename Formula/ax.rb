# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `ax` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
class Ax < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.1635-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1635-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "42748a51ddb9fa8edff6a3b99269aac9c90e25ea08b3f1afcfd4eb33218234e8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1635-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "b389db2ebadd889fe75321d3cad32602cd889c74ade3ea926bb2309640d8ccea"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1635-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0934fde12d2cbdc8368455272dae3081885562ac8c284ccc4ac7cb0a97e314c3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1635-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e9f11e4be6cfda33bb8cdc2d2877cf2e628beb4c5368252cbe1910e9276c3b39"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch archive
    # (`ax.tar.gz`), whose only member is the `ax` executable.
    bin.install "ax"
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
    # Keep the smoke test hermetic — `ax --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/ax --version")
  end
end
