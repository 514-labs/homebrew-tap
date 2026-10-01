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
  version "0.5.1222-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1222-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "7293d88b2c1906ac7f9af537d820a10d0f791905e88b82f703be96de6e7264a5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1222-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "2aa38e6a3835a6363f44a94ce933ceb9e1e2f43d6e54982ce5d318dc99031653"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1222-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8cfb7d84824ec1a9c49a77dd3a9d7c8226ff7bec820cefded295127846d1ce14"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1222-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "693a9f59bae0a564aaf3a46a6dc60824b9e9a7bffa52de3ae3800ffd915d0553"
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
