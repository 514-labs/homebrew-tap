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
  version "0.5.725-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.725-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "a856f8d3c675283702509998d0a999fc849d7cf8e97c098100e1bd25c0ab32e7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.725-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "dca5dd9e0277f2983bca1f52284b30a3ad7e3a153ebf64a99937f2bd05f1b237"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.725-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e9424a27213cd94a5fd1450c9a0d6fbece5c92f3f089d78a5aa84b29b5a076ab"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.725-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b706fb4d7517f95c76e7d4d274467173768b91898ac587c998e883bc82aa2879"
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
