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
  version "0.5.1079-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1079-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "101ad2b19bb92e7fa7ab7b2a2ffb1d8d68679cc5edac76c4b948ee236e0b703a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1079-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "4b0c58a02e53e3079a4868d4cfc1888aeb7b6a458cb2fc82bab00448f62cc9ac"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1079-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "123d46ce727517c290ec582e4dda04c88498e899b75e727fd37c1a89877570eb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1079-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c8974a6d605a60d6c54a1fe412ca413255e4aa484a4c7176c65921a7b361b781"
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
