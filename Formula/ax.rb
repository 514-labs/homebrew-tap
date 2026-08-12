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
  version "0.5.749-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.749-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "a6b11e08d899f58fe9da20627e4ce7aa392480d0faabd2506c27a0f04b951d90"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.749-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "cd93b53c43088bdda20673543804e4ad3cdcadd76c988877cc53fa2c251df17b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.749-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3b8201ec8282d6ac5f39785e03a0d3a9da3dc77086d5601ccf9f99befbee3cf0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.749-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "189d70b5f42de22f047df307e98584cf4d92216efa69c509a7a888af5ee419d0"
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
