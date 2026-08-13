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
  version "0.5.769-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.769-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "4b6c6753a2024774d0ee722212be8289010daeb88a702cbdb766fdd8eb670416"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.769-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a10810d88b009f57f5f4e0c5a9d5abf4d6186b46b588dbc61aac7f111647f447"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.769-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8c97ee5a9c61c570b511dd9ae2fd99c2a51fa3be51a2dd0c532b82518fdc2171"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.769-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "04b897646e8c7556322476b4447d248524a94d51afcd7f5019adcb98f583546f"
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
