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
  version "0.5.861-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.861-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "e6bac444a2709fd58b9a9b6f12be9fe56b4515ad4fae59ee8a0cb312ab9944ec"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.861-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "1a0b102e1ab995bd2442ba9b3475fd5711767dfa8229acb82d5b97f47e2b4c47"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.861-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ebabde3a7d20b8cfe84515832739d2c41749236754f6a847100d82ef5692a68b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.861-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5c485421754722e7f0f96872743ad8fbb53915cfd947907534538a0e79690f1e"
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
