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
  version "0.5.824-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.824-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "d0b44c491384ee281f1d847554602e038e887035ec9363a28ea9a24723976cb6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.824-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "cf568874e661f68db8a263de60301a529f627d876ac6c70e2cc9ae2ecab29421"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.824-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3043cd6bc73c30d504ee71503b3de62c3e53bef468741a1bb3e0a4bd18866c09"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.824-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "71f3472c75f8ec49af5447b8017258dc4e46303501dcb719af5d1debcb23d828"
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
