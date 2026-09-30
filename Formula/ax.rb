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
  version "0.5.1204-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1204-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "a64d01ac260dd036aa86d29fe6d27c4827e8e0d5a8999af13976d891c2c51ae5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1204-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "680e76054f2afea3bbd20695a6a185d0d5bf461fdfc44cf76dbe0e27d3aaa3f1"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1204-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "90eaf3930b7a00f823d4eacb4dc1b3e597fd7796c84f9978c6a615a5120c544c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1204-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "55c72d5a4d5695bdb5423b4ab81f5095bd8a58a25a18ec311e98c1704c95f78a"
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
