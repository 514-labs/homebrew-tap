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
  version "0.5.751-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.751-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "c2072b4ef3c0db5c3d7c5c6bfad08786a4521627be55e566ca1c1ff9851c8fbe"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.751-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "9a5bb4b29c808a02a01e65b9898b077b9c0811dd7623b0a46682c7c962c2ec82"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.751-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "bb6f142b205e6f0ea5edc844918d8ec6d392485d4167a03d37eae10563b6b307"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.751-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8c205bb4d30be5a9fc8b8bcf34379153ec94be9808722522194ad8395636fb0a"
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
