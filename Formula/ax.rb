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
  version "0.5.683-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.683-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "7b65d6908b9807540c96ba7d03e85b3eb6c3d2a997e7c58828abb8f8d2f57d4f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.683-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "5f5370037fab3bf3cddf69789c0e26c1ab350fac05e54af45364789f4c07ace8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.683-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "dde64527dca41f546ba915f50f3e2a903f82d0a9a2a78754d0d7f6370a3df20e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.683-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "af7df99502b87a5d975bc40448882c2c6ad04eb78f9bea3c5be014ba9d7284f3"
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
