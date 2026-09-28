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
  version "0.5.1161-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1161-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "a794e2a3a171a4ed03da6d182592f5e888bd8e19460d8f7910e4c7e3e0929cb8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1161-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "8e8f1c3b67707dee12cbecfb08b9677c9bf94a42ae5c8bcb9223d5bf0efc083d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1161-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "7db6fdcc23aafb67975ecbb07b4ec1248ac55ac2d43f033b1fe5062e65e60c6a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1161-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2ba30f76150c745047d83cb62daa187a2233c133a26592b1e3245533fd8d28d3"
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
