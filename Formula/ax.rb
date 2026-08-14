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
  version "0.5.794-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.794-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "10fc67b8f0f617a31cddabdd248c494da94f1bbfa8f1d31eaebab80eea5c1339"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.794-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "2734f2e35d108f495a6337089932c33ede95a96f4cdce4aa39fb0fa8aa7fa8cf"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.794-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1493ee88b404e626f02fa526c3e8a550fe1e952a4292800aa33ed77c5d123dc3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.794-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e76fa72155b12918ccb5ca2f058ad97c45b06a7d008a3c137af70aee1ab5b790"
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
