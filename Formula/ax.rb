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
  version "0.5.1166-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1166-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "54c9226ea3f2a37ab3f7c403bf4d8775dbf07bc1af2901c4ed8987f4941238a6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1166-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "ea8c7f3c4a6d3d403de7d35dc0cb2d9827b79082c079b5a3ba7d8c5999c84751"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1166-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "539c3470a2e4d06faf6d997dc742af3b935b67aaf25d325bb78dd1c5f311685e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1166-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "79f110b25cdb2d0dded1217254dfddd4db99b22a490d3fa60df68bc78940453b"
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
