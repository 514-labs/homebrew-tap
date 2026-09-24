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
  version "0.5.1119-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1119-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "52bc5c65010496ac301e1db8bb890d22ec7d86ae905167f03e256cf1f82e0aa8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1119-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "40ffc7e7558d7b095a5b8d246830d3500d4c870305094e2f1c28ab00b2a0e7b3"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1119-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b93bc002a374061713ccd087e2fe276a9e457a333fb84cf647e1ab108bba5a8b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1119-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "21238d0169205fd909a3876941c50100f3d8fa9bf9bc0035d91c6bf800ec63c5"
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
