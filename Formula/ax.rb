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
  version "0.5.982-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.982-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "9d49226f971aea159862da73a29a32f0bd470480e483ce0cf680ba3ed4b1d159"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.982-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "c0b369cb541402a8e940faddbc5ae06220655ee7e0625486658312c68d58ffb3"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.982-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3a104595dc92a93cbbcde9380405437cf9f5a4d32d13db550bf9730d66603a3d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.982-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2ed0041e189315747db16c0b960320c56e77142a63cf744aa6cf3381c5e7d2b9"
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
