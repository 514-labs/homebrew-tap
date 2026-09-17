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
  version "0.5.1066-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1066-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "d5b718763fde3e95f0c674c9d958b83a985ae3089465a271a5db26585e1d7985"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1066-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "405d32554b6dc27bf8e963dd75c42eb310e2cd6c02983c5f7ba1c06f3436c7fc"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1066-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c3b9101c50f8ef77c70949b450ab0b2a64bc1cb203683ce75704d0928f480351"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1066-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9cbe9758d332ca09a70e0a220d7d4b2148f80d8b4baf0a47167810e32bec7ce0"
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
