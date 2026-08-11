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
  version "0.5.735-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.735-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "2ac1e320af86dd31a728c811bf4cdc7edf26ab97d128da77f1a7e576acbd2285"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.735-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "216b089d6040d9362d0f8df27afbfc373beae692e64948db137515b3a65099f8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.735-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "7fc460323111e54c7230d70fbf12372108739c3a8fe2414ee9fec53437b9f003"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.735-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "945d600d20ced288c2e9a609706bb9231070b158723182e95e9130224b056cf6"
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
