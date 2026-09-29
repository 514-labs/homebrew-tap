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
  version "0.5.1167-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1167-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "44ac2d5564bed249ee61a7a8df001d259b81ddd851bec1d9dad50a70fd98d175"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1167-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "0ed5d8f6bef659b11d28e31e3565fe8e400e6c16dffdc59f03bfd163e5534a00"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1167-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2b3bfb58cb5d7be96631a8be219d5f00b2b749b7aa77ae30ac878ea661a59c6b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1167-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "abd3a5bf90df99d208e83442eacf78eb21f6af58dbd8c2c21600af490ea320e8"
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
