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
  version "0.5.869-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.869-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "e478788bde2d3da084b5896838e93a4777a260de0a9c8e48adc6de032eec5f2b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.869-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "796968c0991e5a377c1b038763b8a8d25baa01557bc30965a664ee7242e73727"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.869-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ec04dc3d43e6c971c7c35ae5fa9f18c3f9ac0d810ea7066b97d6ae1c97ceaed3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.869-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c532d8fa33b51f7f79dbe7906053a7f21ece43bf512677f2b371a8f735c47e63"
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
