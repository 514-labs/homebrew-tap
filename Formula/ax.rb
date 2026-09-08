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
  version "0.5.971-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.971-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "13bb52281651523cba8eecc9b1286e67813eef12e16c82ac50e3932a0e6eae23"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.971-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "ae5524e74590ce6e73f678ebc65f2990e26e0a0dc8ecefbffab92c66d26a836d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.971-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "93c0c134fbb14745678b8464da1e11b4c9ce4ab8b6ca3cc212ff39aa826487d2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.971-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c288a4a41566224177d4f1a31a75c6bd350f7812aa47c57dfa6c17c43da8179a"
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
