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
  version "0.5.900-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.900-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "843a26a94722273806997be4d804da5a88339ba0e7ed2dba8650a8d4f4a9d8e8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.900-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "48fbba6f7effd84dbd86a65e52b31dda55308f324dd1b96c6855165594e1c86e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.900-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9ccdd86d255534aeb85c5e27d5c99a7c5d92ee7b818f14ae738ff0335dbd8597"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.900-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "7bc9a6b1c29936ed8843f32f383bd1c2bd7cba0ef07aacc740d07e4fc0e6d5cb"
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
