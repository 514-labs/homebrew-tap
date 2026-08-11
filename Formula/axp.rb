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
  version "0.5.733-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.733-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "2ea35d9fcd90edd0ac410b9c11e3068ed9d0f3469dbcbc74775799b77c724d85"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.733-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "3f96d70193d07fb0da150a85f6be4d696a91ac61f1dd71a68c309512ac4b5e1d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.733-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "4657118521bf50984b385db897d2f76ed96e0c32d8591026bd119b24c90739fe"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.733-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "c4c009550d99051011317746d2ff07c7278ce4464d9c99a6e2a71d6b4ac4bd34"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch relocatable archive
    # (`axp.tar.gz` = `axp` + libduckdb sidecar). Install the
    # members into libexec so they stay adjacent for $ORIGIN / @loader_path,
    # then symlink the executable onto PATH.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"axp"
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
    # Clear loader path vars so the test exercises the archive's rpath
    # ($ORIGIN / @loader_path) rather than a host LD_LIBRARY_PATH.
    ENV.delete("LD_LIBRARY_PATH")
    ENV.delete("DYLD_LIBRARY_PATH")
    ENV.delete("DYLD_FALLBACK_LIBRARY_PATH")
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/axp --version")
  end
end
