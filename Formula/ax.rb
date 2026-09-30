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
  version "0.5.1187-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1187-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "e0a4d3d1283f7e3ceb9343968006b9754d85c6ca811f5737c08bed0caa4ab6a7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1187-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "e0566e5c40d73b0dc352fd4fa58e2c3b61d8621e53b89679ea0e50951d517af9"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1187-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b293c2b133e8e0d4f5879d79616a6443ddceb6f1636a05ee57cd7e1e8c66c17c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1187-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f2493d672a3e2006040d4b9152c7d5c9bd67ab3e1a674683ee68bd8c5167ab51"
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
