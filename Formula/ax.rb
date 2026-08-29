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
  version "0.5.933-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.933-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "e535582a4bcb48d35b6b4307b33fd6ee405cb532fd138002be603a94c4010dee"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.933-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "b8103900768a3b591780cef573455ed1faefb080821faefa8764a9a1b5c818b7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.933-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "dd05386e24995732c084019f06ee19127b3b045b78e6a427d3cd9f2d04517c9a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.933-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "eb2db382e98d029607e7e7e8100e7b02ed27a4b3f28c04d935404dcdad625824"
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
