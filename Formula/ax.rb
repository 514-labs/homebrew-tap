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
  version "0.5.1203-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1203-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "cf0747f7f7c2bd2e82b36611d55f280975969e2a8b6877d8acf647dfea116ac1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1203-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "3369f8ad50380b47a0adb10fa6f1d8e6cc7aea27bf5ca006c32d0361ed9e1cc5"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1203-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3f6d4d8a7c8939557a45f3913e004364b3d72def7a0ebe13ded557b46289e144"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1203-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9e1b58bc746c4976bac54e858c85ee25239e01ac526ec8e11439eaa027877107"
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
