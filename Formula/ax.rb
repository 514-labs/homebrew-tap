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
  version "0.5.754-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.754-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "ebf0f10029c02f4ac6f3d1ce6eb5f514b240bc449287cb92eebd91edd4693af9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.754-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f0192598f3048e19496e3473a00fc288d4a386069fc72152ab013bc8c57b199e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.754-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "bc8762250b6b26a8f6edbbdaa9dc36793c256b2de2bdfb10d8fb2254a5c53114"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.754-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d57c8abf868ad8552586c12ca9792b7222636b342c454e3902ed24aa5be0e1db"
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
