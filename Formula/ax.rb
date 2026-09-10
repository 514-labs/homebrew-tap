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
  version "0.5.995-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.995-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "30108c5b574d4cc25f85064fcbcef72ca37c391c293802670d236fcedc0dce71"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.995-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "b287bf7f4bab789e0d6ca4497ec6fd5678bd686b3aeae54ba2a7e9a98be76cb9"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.995-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8a44763899b6d5b80bf1b51fc49136e9817db80c13a838f3eddb5db4c830999c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.995-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3822516b625173093eb5a1c99b53dfaa072604b5cb22876254f5cafc432ec5c8"
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
