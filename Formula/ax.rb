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
  version "0.5.678-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.678-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "996b56ca63d305b5552146078c8750d6db7aa20e9ac213ef29bc04c9737de32d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.678-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "5ca9e26f4de2d1bbe32e50bb4bd60b91201788eb6f68d38da72a8dc890804f22"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.678-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d69c70cf1afe93e11ae3d9cd7ff2bfdb9fdc68a8f3fe9fae9304338d297ab907"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.678-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "577da76e59ef0982337fd6b2122f68471b7063bedaf10f3de5369407d54483a9"
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
