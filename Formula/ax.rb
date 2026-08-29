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
  version "0.5.928-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.928-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "6cc5bf300410d7510bac80f2f38cbbc7fd77898db4c5834ce5a2c48c8015fa2b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.928-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f1d998906dc324f999818a4b78771e8fd63272b47a8ec7e5106adb885afcf024"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.928-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "697c111b6ba38a7341a6eff598232d54c2fe050a712e73a63da5b2558b177c3e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.928-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "284833e1b8234aa0d01cf108bee26e2ffefb9a6fc24d1bb0e28d0a1058a80cb0"
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
