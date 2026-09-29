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
  version "0.5.1171-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1171-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "71a1d0783e9a239ce1add093c0b9c92fc0f40750b7e5dd490651f2925698ef64"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1171-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "cf5d80f61cb06f5731f9c0fcdce78e7b9a6a9a2eb22fffdc5f53d0319e58a42a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1171-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d682aab01716b12550b9f22a63c0a747499d9d13f8a3a7aabee93e219cc9ad23"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1171-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "33ef5c4cad11eb5f6661a8dfc76e242b3dbca01e28118adae24d443cba84b9ca"
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
