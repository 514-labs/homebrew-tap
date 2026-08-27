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
  version "0.5.907-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.907-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "1131f5c06baf7bef03e5a26d003d6ae47452fa19c77cea0f31829a0538231fa1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.907-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "68dd21edb50b7820c6bbc41a00726597bdc2a9f76b1109fe5a02554127c8ac27"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.907-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6d8085f923d930fd0a9441a1662d01b940d080b9aff14ca40bb9c99353b016db"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.907-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b1506fb23f35bc71d9fe1ba7628e0bc8d8baf8ac9a7af29d424cdcc3f5c279dd"
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
