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
  version "0.5.696-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.696-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "3d59a7bad6c46ec84463858c8a2e48f51a551144b7b23ec6c4b0ee4c5f5cf616"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.696-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "2fd75b6a3da6cff396ae9f4c1c1a2f8873079501f6fcc3b7509e78a30e9c5a42"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.696-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a1a5965424cf3be567f29e7c1d1e8cf0bbbba68e14e2ab1af3a0dfd0ef28fec4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.696-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "fedf448869ff8a6a528c488c0177f00be7d7a29f9b01339fdb061485fdf11b88"
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
