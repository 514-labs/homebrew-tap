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
  version "0.5.844-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.844-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "0ef584157277538171f8083443b000bac6361b8796d6136e89cb79c21a36f10c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.844-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "99267759fbfbcec0be80db23792958cd2f18f9d69ca114c3bf144b9f18c4b69b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.844-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ab039660c1cbe4bd5d2581a74dd9e44424c26a7a100a2ff975f600c90ca2bd9c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.844-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "27da938e0c2271a725570f6dbff416f19ac8853ffa16fc0a3b2fd486e2d844a7"
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
