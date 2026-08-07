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
  version "0.5.699-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.699-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "b979f671a1587e23499c26032f8b195ab3f36b28c80227638d8718411ef6797b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.699-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "bd8a7f07854bcacc702849d257ce5d6bf0aa00e495fc860f970b286190387a01"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.699-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f14b9c89b9d86bd1a617b823fa718f391b822f52b956b50c9f6bc89870797cb0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.699-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "7380fb0cc45e41cf6be0af31dfe1b7aeda7c3b23e02c3ae0f185664341177ed9"
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
