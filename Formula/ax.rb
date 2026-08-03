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
  version "0.5.601-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.601-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "841c6c33bcb7430ec62196ba4c3e1a98ca0bd1212e1cb3a22eb408fac15e4a95"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.601-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "6926c3d9a62a902b00b4fb8adaeeb9d341ba9b850d84882749a21202b6314aa9"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.601-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c8c439798bbd3d40b5f24fd746dfe0333259689343607aa9c8735c20f5a4ee29"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.601-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ea7ad396c0c10ee46cb2c711c63ea4d05ece007bb941dcb97f97eeba9f05bfdf"
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

      Next: walk your first experiment with `ax learn quickstart`

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
