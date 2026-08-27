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
  version "0.5.896-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.896-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "36655887eeebe98b50f1ff3259bfc08d4dda8be2e87f494949f1ec2d80d60e31"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.896-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "0cb042e076740365595017f87266c098474501d4f70b8ca02a08d2eb745617e8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.896-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "746193f80e8979ef98e3d4b3687e2ac78a7a24b178c49931819d4503bb55c900"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.896-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "12d9ccb3c04fa9ba3d7f838383e13d98a3c7960a70a6bf5df32658e0a3523a9a"
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
