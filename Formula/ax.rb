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
  version "0.5.817-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.817-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "ac113e69e6038e0438011fa4022f1a388f99caaad1b0c5fcbdfc274f2125fec0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.817-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "0dd6c0d1d238f8f554ea64a498dac801bc20a42a43a09df184141e12c58f58a5"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.817-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "74fa87f3c53955dfac4fe4da810f4ebad176f8608d29ace4b370e8c730407dd3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.817-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "cfbc155232832ca1386efa8ad4587fa157605e47084fdf4a9e880b30097521d3"
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
