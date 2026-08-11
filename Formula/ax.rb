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
  version "0.5.734-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.734-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "02313e658cc53dbb87c9898ff79e947e5ed1edcfd8d29d6f6af491d0b6efe5ff"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.734-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "73a337e56f3cfd940cf73cffd9c59488f6cf3c7339080608d442200c473c6791"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.734-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b658ce201ead2ff01906444116b01bd80b1c2a9ba7cc695a6222b7f5aa83b3d1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.734-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "40a3a547fa42b2aa6c414fad1413b7dfeff0d8e77271b26dcdfc44a7aa4494d3"
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
