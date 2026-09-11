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
  version "0.5.1014-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1014-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "be8f4815471000ea270a06660829aaec79e884dc2170bb5f3ae25f5b01e1417b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1014-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "8ef1614744a961f0ed4dec5449cf7bbcf0bcb8446cedb7eebf19bc5f6579dd76"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1014-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "585f852945cb1c7cf5b158ab7a40ac77b9805e2057a4544a1c9cd1dc8c41db4b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1014-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d772d90cf6206e71f3a0bb070b75ce2d4a4bd98bbb8bf6ef95d5f01fe9402001"
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
