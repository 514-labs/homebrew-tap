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
  version "0.5.1000-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1000-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "23b8629658e406ee9c766cf1b0634b7a1e8ee21a00e93aaf3d36918f8eabc13f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1000-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "fda2b1d45f3338a491159688059f40532d7b8194f019e5326252cf2e781605ea"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1000-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "746983e54691190ded7359da3fdde52d5c82fd6d33a70c4c39931437af61b4ac"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1000-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c672485992ff2a6ac140b78ef12d5091bd618c191d7002cc463b86b60dd45028"
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
