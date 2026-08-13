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
  version "0.5.753-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.753-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "5722ad85a4f8aad44172f732c2d70f31154e26460cecd7c8d504e0d263f3a7a9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.753-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a50e95d4ad318b3b3ebea4fbe6ecca2989ae21038803310203ff95b9aef77aed"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.753-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d329f5b4e3b073a464f768e64d014124305a2a134da9660bd6e14ff93ee83788"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.753-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2b7dc25add44f33bb007eabade2c56ac4359e662737f9769e5509f3417a87ce6"
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
