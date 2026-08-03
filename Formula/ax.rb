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
  version "0.5.622-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.622-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "cb48cfc99b7e88fab769a74a93310e8b210c68db72d5585488aaeced61d2423e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.622-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "5ea63436340df3b2562fa1013d453a8db9e63f5761751fc8830abd3e97da6060"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.622-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9b5174297cd52a9c500967b610ed04652c24868490f1f1d65ba0aa4a05ba4c79"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.622-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "600d8aada7bc57ebc6a3ca223a4809ca28d4a8a35f02b25e0a1723bc8b7057ba"
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
