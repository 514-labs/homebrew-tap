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
  version "0.5.778-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.778-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "b47fb99f0c4bbabdc31ab6f7cfd3f50400b30109f93ef88efc0edcf6111bc7d2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.778-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "65f43acb42f33b909bb84b81ff776298f9f009365db94c25c613bfac1c1aef37"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.778-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b7173c74041d7d8f0376c5ba783d9fd14c7cdb7d59f1e18f2421d957448cb1d2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.778-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "93e55b961537f40e090831154a2e0c1367067d68e6f1028d982691573b0974e1"
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
