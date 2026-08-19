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
  version "0.5.825-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.825-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "4c634a3d6f5d0df18ccc17e36d236a3a4199726a5b85464c2c931e3db6c92adb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.825-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "98ed9030c682f2f3ead9c8b6673d431989fea2812804ec21517315f5c4cd3e1f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.825-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8757aae91668c7cc59673cb017fd71e2c440d9c7ef3dde5bb3ad32837f2403e9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.825-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2384239d970f2c15037af2cb461b623bf3cdb6c33b3ff53a06840a9a840cb2ba"
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
