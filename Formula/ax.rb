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
  version "0.5.743-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.743-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "12b8d815f605fe90babbbefe8090d30df1311d5b1a36a40838f987494fb40d45"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.743-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "59143d217ce882a350853102f6314963f1ca2a49cc6ef24b0d6523e4608d2ed6"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.743-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c75c2d84053072c5fed4a6f91917088872a0f9692620c8a382a8992fc9e141ce"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.743-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9ac0f0ecdd291188a0e53922ea11b8ed3dd187e6c4934c24afbb8cbfabb1e74d"
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
