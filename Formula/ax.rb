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
  version "0.5.1212-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1212-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "6e761a6e18b3606c01ee1d3f127bac0d06753e845d24610d46da315511fea500"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1212-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "6d89f12e1724307b8d38879af10785c6ff1b84adc773b4cd2f7bcabd3b1aa05b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1212-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ef0942dc3c7ea9f2d39601177fc13469f568a7dd464667e869f235ce82c55695"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1212-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "927484d14a13b1bc7ff61774fc8badb5c4ee576f574130776c8f183f2f915c2a"
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
