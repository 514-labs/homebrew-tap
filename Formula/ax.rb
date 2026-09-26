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
  version "0.5.1150-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1150-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "df4958ee5cfa72e2f97a5d050f682ea52738e7c40ea0c15171cce56ef83f3c55"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1150-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "bfa679686a2e2f237b2978ca4387b7ab4566c4f39c010a71718f85f138f36e7f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1150-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9ff11b64bef92b5da9331a51cf499e4f4c6a1af7a78f2b1ab87cef76d43ae027"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1150-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d49cfb867d106b79a79e8c796c0ca774161d71a8bb6ffcdf9c227c6cca912f86"
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
