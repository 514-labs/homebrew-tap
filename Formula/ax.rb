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
  version "0.5.1185-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1185-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "42c0d1b518d77dedce37c33c97ef14edfe7d9cf50f4b0c11993d59484e272c14"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1185-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "ab62cf9527f6487f5e80ea67822f1d6efda82f839eb551ae7a7532f693a93877"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1185-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "12e39aba5549a096a581aec9349efbe2c35d7f977f606002ce9bcfb53d4e388d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1185-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "07f7c537e4479308cfed365e309d6b45d6b99ff6b5c10286269531d8d4203417"
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
