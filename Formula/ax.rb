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
  version "0.5.838-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.838-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "1a79af2979a3013dddd422f196b7c145e4fc9e2fc4537414b8f00f69685b5882"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.838-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a79f3a14138524acc97acbbb7911a9d953a44455e28ec140b40ca3366c3af4e7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.838-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "638a8b77720691ec543d4ec83b425c32bc8daad8fc3eea992ec941a0215366ab"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.838-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0d0877a987cdd86c0cf059c97a4ae75e0db04891cae8ecbbbae6c4217adad227"
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
