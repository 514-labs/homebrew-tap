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
  version "0.5.1192-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1192-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "0f687fb73e098b0bf6bd50407d06f07739b6763ad709e613396c3f03f805852b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1192-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "41e3d4a0eb5d4e8efb01c53eb55831c38d4c436c24cf6feb9edfb1a65a5fde52"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1192-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "7b0a0f068670436b172d32ca930a66d5c94c3ae9d47a0d9481109c70bfcc8129"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1192-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "87237ff0cde4d97fc494c92da009bf1f727a6295bbaa0f0275f9a24e7316791d"
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
