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
  version "0.5.770-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.770-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "a6cec1b4f857c9039540786a4534f0390dd84706bec2b10dd9a4e737af232745"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.770-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "60fefcb64ffc7960cee1b12f013793758b5c1759e7bbfaef6d914e69f2e912c7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.770-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1ca914fec27c6faa4623f371ad2ca15a8376d50213b6019b95b2ffa578ba08d4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.770-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "110952584a63f6717ef74ab8d1b83b6097538be725dd99035d7eae4d147a757d"
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
