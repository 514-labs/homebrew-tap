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
  version "0.5.978-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.978-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "6eb6e29d3ad29049e52090f279976d2c3ea7038a0d5a9d627aa319360f8a3cce"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.978-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "9b60a6d509377242d4909f25c6b334a43c96b0e837947353a1fb1f6905cee8bf"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.978-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d84874ffd78ec2ac0f2b90c2c95b05abcaf2e8c7910bec262853e54186e1152c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.978-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f92d966d0fa98d3d205feda05fc17ce70ef456c233e1b0b51bef29de6eff6b35"
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
