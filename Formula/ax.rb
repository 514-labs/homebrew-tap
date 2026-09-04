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
  version "0.5.957-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.957-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "aaffe606ad09a8345ac9d4836ed8d47e7570d4a7187807f76fd722a03c86d57b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.957-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "e822df74904576152275806b4a34aac0471aef2992825f524a1f5fc6589e17db"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.957-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "55bf5ffd77cd727a135718bbddcce299e36dab4a3c554abb61f4590578f72de6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.957-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "bbaac8ffde418ad32e341ed88528f2d1e0cd3b98ef048401c734b019ec5cd552"
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
