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
  version "0.5.1020-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1020-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "cea255d9608eab2f12e2eb4b64ea903dfa9b7d1f79e7c33ecc0b1d7b92de61ef"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1020-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "5cb80f386ab6fb2100aa8349a63f01a11af20c47eaa901b01007db3fd3bca0ca"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1020-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "161bd5f6a7229d0d68a01dd1d6a3d278a9e1c666f361219fec421e8116ccf808"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1020-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "26a52dfa841de90b546508e4e55eb115c5eac34b6e2a0991ad748607cfac1353"
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
