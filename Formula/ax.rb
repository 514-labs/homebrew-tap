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
  version "0.5.1030-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1030-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "c394ca09f5f83cb41d687c0b1bdea4fe483636259f67246ef21e440df1de67fa"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1030-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "5a1d2e10e90322e1be4660053e6bbfcae22ddc1aede606223ae2094781c1015d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1030-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8b7d929a683697b84b0ca90a7c610105c55ba5b62b5154cc7157e9332637e831"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1030-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1b6b3177f176cb8c9668b2c7d728cb25674c7cfbf0debe8670e8f2692c3bdfdf"
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
