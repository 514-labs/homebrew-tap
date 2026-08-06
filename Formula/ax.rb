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
  version "0.5.676-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.676-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "4a1dad0fe177da0da97bbf5e5d79b83be1cafc017b2454ac3579ca86b4376d2a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.676-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "258d95f63718b16aa61919334b6f8c33d9eb4f87aaeded58718c54efd91863dc"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.676-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0e91b5c15274e857783f5237851b26fc29cec69c7e8d824dc6c0e6960d4947fb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.676-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "df09d3809cb3a035733545d8a7f03956050deff909d0b8c422d54884c0be2372"
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
