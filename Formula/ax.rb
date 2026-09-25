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
  version "0.5.1140-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1140-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "75f17ca5af19f876c4fe91c05161abea7f99ed5a409e497921ef74bfee6bf44b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1140-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "1407bc7700dc1ffbcb89c17113ec4d52fb179bf61ce8e2a9a6c965144ad0fe09"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1140-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "92f556d724b9ae08a53cebd3467d36fb90fbe25e06e38e2d9cf4d9d49ce84f5e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1140-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6bebd5cd5e9961c918234aed6000642db2949f4e8013809df2947feeb1a00945"
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
