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
  version "0.5.630-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.630-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "cc8079197aec5631fe4dc61dac46f0a0e7f41f8045684b5ca38b0ffb41a49490"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.630-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "fcad5c10c9a816d9f5e95633dd41043208c4cfd38f1c74463520d00e8818fcf1"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.630-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b4933508a7a8851d3004fbd03ceb829328804b7c501ece2d6cdc6a462406ed2a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.630-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2a03c1e465a8982c9538fa887bd969555e92d8e4c60d53a44412ef745126fc8b"
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
