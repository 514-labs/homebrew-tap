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
  version "0.5.1091-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1091-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "26ce1ba7645d76360b6665e8366bc624f393a58de02ed07e5be14d964d4eea61"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1091-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "9af9720cb5ce079aeea6a136d1a40176f6d610f0443c8e9438208eac0118a0cc"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1091-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2a5358b12bf54ea240f8c1c415db74e85f6816c4b1256cf7ab06571713a14b52"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1091-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "560a7343818c31984798c02bfd910814507a53b9c1fa20a9b8a7ca20d8aa0b8e"
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
