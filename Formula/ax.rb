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
  version "0.5.1144-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1144-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "bde5701a0d5d983c5ebb84b3568d13a5cbb4c0a3f8f54b908ecd30e466df6114"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1144-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "261443912ca665bf3a9b3ca807b22f626783f86e093869a0c7530eaea4a35ca2"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1144-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3e491e0cb606607b99fc80c9778b0d224d1eb32307b8a9df5368e2b2e392d546"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1144-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "162c6ce54ea08e924730e2d82eb2aa9c979deb6546eea3aa517c59434ff1a902"
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
