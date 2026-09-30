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
  version "0.5.1194-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1194-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "565b475604d7d8d49ff59f7562322f93aa82d39c967e3a35e24b6e2658ae147d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1194-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "256e8453a9b2c641882049501da481f5daf5c9a3c4141a70bde8a0c1ee7c1bc2"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1194-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "56d025e27642970e3e398b4010c25b3cce3ea8359e6149641c038af2c1e9e9e6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1194-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "cafa0a868759ec1714cd4033e3474b59a64c851fea95696d8158cf0eb2e580d6"
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
