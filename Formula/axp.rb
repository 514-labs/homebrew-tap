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
  version "0.5.889-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.889-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "74a259bfadb6e4b0683684921461b5188c6fc35b7e7bee7f12f5ee1b4311c8f8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.889-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "e7f20c767eb29e14a31aa31f391b5cbf9d041cf872d96d5bceea7ba08196f265"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.889-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "26c4a620e93f6f44834d9a29d76d1b5b19bffd4a651d13a1b47d4e294fb3dcde"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.889-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "77166a31736943d03c46d8eb191585752aa1fdb81cb65c23cc377f6a978dbab1"
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
