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
  version "0.5.1098-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1098-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "666c5dada925619e5f7599f05e32b1ad494e2ab6734b4f9d46bc07053985907f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1098-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a1659a9b17a2297b1eefad1534adca854e768a36436bdcb1e87121e25786c082"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1098-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d31c60516e9f4b5c387db41f89c828a91b67bd1dbbfa0cf7fbb3f7d1ed6d8e41"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1098-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0ae9b8aedc64034460edcda0ae76473648ce3a8a54c6e48b99e17f4b90a34cec"
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
