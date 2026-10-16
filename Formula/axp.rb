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
  version "0.5.1387-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1387-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "8d4bb4f68912e76b7f2c5466fce77754cbd3e3541cfc33e8c694d9ba599f31a7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1387-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "d13437ab8772698b5f0ca741e84959897fd19b25fc9dd4246c179d74d46dfb1d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1387-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "c3efc433668adce1ba48a2908cf07a736122ac2a78bec1a8747d4974ff748f61"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1387-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "41fec3d7de4cce7fac6d7e101a5550ed1e3ef495c3bc7879d65fd4c483b414d2"
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
