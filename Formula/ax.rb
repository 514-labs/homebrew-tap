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
  version "0.5.1191-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1191-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "f55fc36697cedc638991f427fa7f9bfe3d4861bbf2d925f7219b104b965d34a0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1191-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a5a5e677ff20860b38cb90e396b7dd7305c445fdf46e319647ca1947f4bc037b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1191-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "cd4379eabd44bae460e7a70ee6c7846559067273742daa5d66525abc123b32c4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1191-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "719e8c7f8cf73bcb0afcee1ef2d0711b446cda6db75a2c76131de0f922bb6ebf"
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
