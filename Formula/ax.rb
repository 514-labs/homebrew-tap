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
  version "0.5.884-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.884-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "ccb3b8ab23452095c6ec3e581e9bf357934004c4e00ef037af18041bc6f68b0b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.884-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "5ffb5f1b723b70d59b8dde04b2fe588582e97ff49792b7b4fc00c457bfc140cf"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.884-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ba7e57fe1cb224e090970790810a50eb91299882f0e28378e8319b27580f2d50"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.884-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d050ebc5943bff09e96e601b1ee88418c2c1604f6ed58499fd8509ee0aa54ab5"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch relocatable archive
    # (`ax.tar.gz` = `ax` + libduckdb sidecar). Install the
    # members into libexec so they stay adjacent for $ORIGIN / @loader_path,
    # then symlink the executable onto PATH.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"ax"
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
    # Clear loader path vars so the test exercises the archive's rpath
    # ($ORIGIN / @loader_path) rather than a host LD_LIBRARY_PATH.
    ENV.delete("LD_LIBRARY_PATH")
    ENV.delete("DYLD_LIBRARY_PATH")
    ENV.delete("DYLD_FALLBACK_LIBRARY_PATH")
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/ax --version")
  end
end
