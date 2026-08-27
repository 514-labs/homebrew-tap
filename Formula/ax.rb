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
  version "0.5.906-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.906-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "335a0be59c1d0ef631b5a4be71adc6dcc2a8033eb72c98a8519facd5102a49c1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.906-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f6aeb628fea150708e354633412aec261b1c807d3a862bb4ea779373670d073d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.906-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5e4d90ef6df19d55067f2a43b5bc6e5739adb263ec43059152cdf89a79183116"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.906-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c75c9c83f3d91e50090e17cbc0fd967bb56077a7dfe0c1dc322804aec5aafb10"
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
