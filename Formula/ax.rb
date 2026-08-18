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
  version "0.5.818-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.818-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "e39165e5f03908ce77262c466d9fbe423b7b3f6530b31196aa8f0e06c115e658"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.818-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a09bc9f051610956b6573ed41c423ab76a07ac6275bf82e73159f8da0d431be5"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.818-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3de71814fff80f57ffcc38b6912da93dd28e34a8039c30a1519084e97177e923"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.818-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8057e0b992edf8053fb27e510ea4195c2a4d3ecb41d5d57ae15cd5511ee5337a"
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
