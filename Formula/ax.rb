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
  version "0.5.641-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.641-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "1a5ea98aea0cad37614b09e505537fb021a5477dae2bc47d6afd8e07edf5ee99"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.641-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "62b1af3ae518733afa35ff6273f41178655e656d922f4c8ce1a75ce8f48b7d0f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.641-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "62ce6af08c3b6aa52121ddee721c27779c96d2f672ecf6a93a0a305ce93468c3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.641-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5d8ae3472f3db35bb41b682fd3d9496a512f553ed95e5e36fae3b732920eb6c5"
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
