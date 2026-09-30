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
  version "0.5.1200-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1200-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "292a2e4f344927e88a0c00e394d9a10e2cb43ca76c90584c210124e2d6cd5d09"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1200-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "d8289724a4e564aae26ad110829ef61e59c8c1beb1fdf391458f347e0b186818"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1200-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "016137de5fc6496a699b27a3ce61850cec97bd72e57b969dacd4ec96e937e375"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1200-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "47681ea89f0657c9d1b56413b01802b26797a22717d846138a76ba48053673f8"
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
