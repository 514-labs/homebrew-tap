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
  version "0.5.691-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.691-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "c8af69cdf167de282d99764c646f3d8c4979b6c302b9f91940b8f06f5c5ced70"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.691-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a486c197706b48424ee751a11e8bc1bfa3d761560be9d7c7ac3b8afe137f759c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.691-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "fa6d6af9bc229b0407cab48dff5d9401c56c5866638fbceb65cb61fb53a7da4d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.691-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "80ac859f1315b1419a1c0c649df66544b575675370fdc7327eddc6df9c474d33"
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
