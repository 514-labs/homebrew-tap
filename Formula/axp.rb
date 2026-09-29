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
  version "0.5.1165-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1165-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "000b1023dbbe7a3e0be89189d0ee9ddeb3e0ba29c4347e60fb1f37e234309a24"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1165-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "c9e29946a5855bbd75fa450c07d423a73a458273f96f545e0950a692828d166d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1165-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "fefde449f298834cb87051270e40500d8cc25a17df36e05d8fc934cc89ba8f88"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1165-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "707a31001f3084712d87eb0c1fc75590a9e19c76e5f85f14ccdf603ff44a2e59"
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
