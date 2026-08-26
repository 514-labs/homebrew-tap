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
  version "0.5.888-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.888-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "b0fd2d86b22df8fa7af9c78a6d9781c5cf8a0989a2786ff04a9377904daa610a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.888-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "3557e78b9396c1268994ddc330ef336dbb4cc5cd92cd082ce4f770d01fa7754b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.888-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d04e0f8048344bb9a72d487d196395953f6a1f6a1bc41c88996bcc11a3d3df67"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.888-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "54e062fcb537ee4fa91444b49c888d6afba00784ca3bea253f946443d009897b"
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
