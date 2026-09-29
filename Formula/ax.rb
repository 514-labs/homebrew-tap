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
  version "0.5.1176-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1176-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "bfaa3267ecf978852bfb4faf4a50a449ce6b39058c852a5f744f933f21cf511e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1176-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f3c303a4ae73291b637c57b0b8ceb5834f20ad22213fd26155b6ff79f062e1bf"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1176-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8b81aab26df586c1249e20f696042e6156f1207f3234e856a9fc85ecc14fbbf8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1176-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9a0f9b7b8d3fc843358a17adbb3efde9967abe7e5ca4980c3d0d445a3309afe4"
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
