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
  version "0.5.1075-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1075-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "f1841431c4b8d5d7acfb76816a1011caf032cc3d3bc1215e973c901715b5d60a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1075-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "4c15c5b65b0f616ddd1311f62a5ae514fbff434a470a38b6c606eddbdfa33115"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1075-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3f1baa03bfbff0acbf7073b29a6b79cecb5b1c876facc47dbf724daa05b4ce1a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1075-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b332e013dfa5373417530f3494ffb287992864d0d30baa5132cc1e60db38bf94"
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
