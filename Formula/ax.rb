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
  version "0.5.954-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.954-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "03bc8d96780c21f07ba017d83845365933b106f55a2369daf1a7616e2c84a108"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.954-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "75c7df3a67fb1230774a89ac4ac77ff4785c1b24ff3e0ebad049e6c14a3cc22b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.954-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2667a196e212d9e3219bcbd15c9bdebd388f47591af1a3fb450084723021b7da"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.954-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3bdf6cbda5e5285e901cc09554cc0a6cf8e597c7f885e2e5478153f4973d6551"
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
