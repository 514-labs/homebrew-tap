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
  version "0.5.1433-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1433-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "a3822b53fd555c286dfb82501a40fdc6b52b5c41d5e73f55bcab09f25a0f72d7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1433-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "fb9e2fbaefaa1969344df200d2e4c831fec9a9c96e6ff53438d98c60b383af04"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1433-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ccac489e378589858ebc8c50141e8121fecb6dde244a43109f132bb3bc01b657"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1433-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "17218c5ba0406208e4496fd5823778164d3837918b38ac046079b0dcbfe9c614"
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
