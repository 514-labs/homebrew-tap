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
  version "0.5.964-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.964-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "2b34c4b06a60e36b2e243618de3a4347945a441d05c27ec7de3a692cb976e25e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.964-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "fa410e9f859c68d08491f3221d2d6761d1c25b6baede99939739d21bbd8c8c02"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.964-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "58f7a12be0eaa6860f6db3344ec8e3653b275c7010537eb166dc219846c97226"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.964-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "7ca7a9c09e73b25c1d297b820291a85dd0a877cf6eac0e03079fc26780581463"
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
