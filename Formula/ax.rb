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
  version "0.5.758-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.758-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "34eacfceed1afa569d3757d7b6beb79f17cdda42f6908f5870ecddd45bbd683e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.758-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "64c3fc24f3409108f2cf8f280bea58adb6b647d4e62af62c605b4c979c92213f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.758-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "dc655b282493fd7a60f92bfb8bfc20d14a3e9b487c3a7c5b293811f41f1ed68b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.758-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "39808d3d53585667b95e3e9996a26768db8dff92d783da04b695b367b09ac390"
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
