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
  version "0.5.1188-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1188-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "fc76fb8efa2b75e82b73d4e8ae8f98fb99d62773f17eedd9525bf064362ad576"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1188-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "218b59dd3dc6baa57cb98dc92b2bdfe612a816d1c7dfd509861b088e6c9bcc43"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1188-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "7b7dab8156f4f937b150de38e5e1c4e969ae67889da6e8ece9c9f13c969b3df5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1188-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "863615b66b18222836771a58c77d6554cd118dc620bb67becf4640a895aa7688"
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
