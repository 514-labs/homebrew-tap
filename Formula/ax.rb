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
  version "0.5.764-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.764-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "cc64ba80e26a52de1281a9ccff5916446f4963c34aae71e528203b61dd2fa577"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.764-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "69dcb9d59dd6ff6b8f1056bcd04c814a84b5fd622f24d2fcf5d6b0f793111e31"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.764-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "907a78290006fa37dd222cc661839a845886334349bb57da661ed11b79e0cc19"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.764-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b3128c98e5387391137be523bd57c7e459974d61214f9409604ba31e18724ead"
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
