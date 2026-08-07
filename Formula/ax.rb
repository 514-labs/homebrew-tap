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
  version "0.5.710-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.710-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "6c909b01f8a20062b0a691d5c3ae7bb31400216dc0f0e28b01dad4f9a530eeb9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.710-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "0fbe27f8d933d2555e2b015cd005e4d72ad13cb6e2f733a5b57b87e98fd4cc4b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.710-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0300870d358e4216e691ed9f91563a14c711985381a4a0939cab177092cca69a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.710-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "91118918290d7af58daf31b708727b8a9668671d31e0aad4a61fa77c3797bdd0"
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
