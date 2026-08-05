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
  version "0.5.661-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.661-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "966c760006b3eaf71ddf1fec5121d2252043b30efec83a1b0ed6d9bdbb5b648e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.661-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "869125bf433943745596389ff4c78cd015e909fa4421d9b10cde82af63f400c7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.661-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "11fd3345061419ef1339693ad2ac3741154a55184a9ff29bf3d00a67fee9e5e5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.661-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c305f01cfb75f157d87b71550e0c4bd344e8f921e31e899929a3c20911dc07a6"
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
