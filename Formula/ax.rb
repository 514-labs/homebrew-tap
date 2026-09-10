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
  version "0.5.1009-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1009-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "e67c52819addee9e7602e8b62f12fb769f7c08cde0e91db6ed71c1bf13539562"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1009-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f5e2406eb114f0594de4165a355caadf5d7c4245f4395a161d3650c7c7e4f713"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1009-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "baee8c66c34e7794b5f18192a5455e5b21ff94da83c2a87c3339c58bc972f1f5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1009-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d207f61a958e0ce63ceae05a1214fd492277b9f07e1eff8aee2525739bb7a10a"
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
