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
  version "0.5.1022-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1022-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "26938ea5263c85b94a437bde147c8056bc55ed7fe1f895b2b1240ef1094e6032"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1022-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "edfaa84180d477afa30f1ef317c971e5704ba31c06aa760d0f3b2ef943f5b3fc"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1022-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5e217bbf7567af5b893c456e5d4871e9894e6b5aa04f4b4f4918b6796721c498"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1022-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5ce4d1ef7224b7767c10c0a0d80d47776e7538282c697797de9caa6c9b75d7dd"
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
