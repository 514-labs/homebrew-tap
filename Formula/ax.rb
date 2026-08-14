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
  version "0.5.782-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.782-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "4479d988a17d3499ce72b21ebebeb93c2d306a411c69d35c73a5e4ca933f64c8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.782-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "aa6d8515034f0be2ac4cb110a04c8aa7e687c64b18a3fbed4e12dc9608f1bdf3"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.782-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "56659856c4949037fadf7188c6634582460a16365f51243d47051fc08a62fade"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.782-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "32414742cb2c9b5d8f8a70b49dea5d7df2db7ae634fa6ba1d58d9555f4de7abe"
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
