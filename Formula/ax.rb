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
  version "0.5.867-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.867-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "6dde597f3b1108d76dc77c40f3664f72ded3ce263182e0e82fc13e60b169a03f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.867-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "66962e6a3041122ee8a295f05c2490497e2f6435d2bc90620decd0f88a890609"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.867-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5d52f04fcc4361dc4c8f99f29d413f596df294af44b892cafd6e8395b6c39a10"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.867-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0efe8232b7f1aeaf173b56f7b90ed9e9b2830c09d65c1ffe4af9626ab1399e92"
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
