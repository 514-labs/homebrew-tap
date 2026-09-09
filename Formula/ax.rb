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
  version "0.5.980-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.980-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "68ec89612b233da88d8452693ee550577071d7c0f2037824944a64539af8730b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.980-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "ebb627261372810a62d11fe0d980d0a178cdfce8f6dac6e5d442f79b0473375d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.980-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9be82aa17fc0cbf2ff3d9bfa7b02a42a5bb74a45ac6f92bf5a6a08a937d3116a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.980-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c429ca0fb53443103e1df897499e8c61c0e2c3c03457f4fa525f7032dd94238c"
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
