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
  version "0.5.1001-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1001-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "03aee2281a9e76c188323da8adcb56467be6b42f018c2b1c4de5a0bcb0ac5076"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1001-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f2460287007865624d0e3ec57e610a6494b54738b7928052bd36cb24c7e4da7a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1001-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e6ba743ebea8091a6368039cc0744b23a3ce0c84f1eb7f6ece46ab26c30c9dc3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1001-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f7c8e5d213c0eae1730e75f7badf437ea03b92f15890f8b041b877db0bee1257"
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
