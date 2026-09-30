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
  version "0.5.1205-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1205-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "8aca7603dcc1b7309e0bab783d37ae21973a2cb0d7c060a81a2d431c358ef6d3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1205-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "c4372c768afad7ae9b51fcc16b4ca051425c93482ee34123cda8af97da170438"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1205-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "49bd60fc2f23704f01fbcc42c6c60aab82178cf793efe2df3559b7f2a73a01af"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1205-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "7a64b4d54b6681241f6ddbab6f4efd6a79e10e5132904e44c9130583c213f28a"
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
