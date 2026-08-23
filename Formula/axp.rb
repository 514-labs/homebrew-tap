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
  version "0.5.854-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.854-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "a9ebe8a62333da4d4c6f6e189e2db88cf04226053cefc9ca4acfb77cbc5365a0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.854-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "e7fddbfbe76875571c1116da2fae0c1a3a8c2ce2086c015a075fff52bd08b92b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.854-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "4ca2cca257d44c5f75dea8367ca0542204108e84619015412be9a397481040ee"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.854-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "1341425d7c880684d42118f66ca512c25990e7a88bd95435512e0f5b5e03a39e"
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
