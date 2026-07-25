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
  version "0.5.449-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.449-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "18783ab554d7b9a61b0bf43317deef2956b3bd8d2f6b6f3cc8c6f28828f7a9e7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.449-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "7af2c21a5c01ca2e904ab1a5e3059e57983cab01669a74cacc9671a9d2881c88"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.449-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "00d68ed0cd8048a316513324b6864a1606f06a992631488ac36bb5fdd659111e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.449-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2ae75220e8d8d0d5d3bf98ae9e5bce85ac99965a4cc0662997211bf8d0560aaf"
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

      Create and run an experiment:
          ax experiment create my-experiment --template cli-install   # your agent writes the YAML from your product description
        → ax experiment validate ./my-experiment.yaml
        → ax experiment run ./my-experiment.yaml                      # smoke: 1 repeat per variant; scale with --repeat 5
        → ax experiment query <exp-id from run output> --metric testPassRate
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
