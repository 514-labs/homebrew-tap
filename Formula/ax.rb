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
  version "0.5.1107-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1107-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "11e15c0950e58bdc60754d6c4aa4f950fa641e18b20d9b42435c67a589c90a26"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1107-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "c357171791776a73e4f860ee725070fba82767a0d3e42413e442eee368889d1f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1107-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "352b0c06272a4f2bbd70a7c235eb61061811f978feedbd2abdb17a765d1c939a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1107-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "cbdf1d5f79be2af3e402d453829cdf3127e0eb6712f60f13a5fb74b45c8d1ea7"
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
