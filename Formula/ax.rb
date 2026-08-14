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
  version "0.5.781-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.781-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "48a06ec76d7f5a4d3a809c96f65d88880a7eb1755bb4f59c6e901087fdda494d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.781-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "0d9a98ff543acf812f00a588ca031fd2b07182cba9edac62ed8d106b748c0d00"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.781-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6298984ad65f2ba1b3ffe9b1407c76ada5f52f3cc521a42c617252d644e148e5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.781-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0f91d5f2e2ec5000c5d9efd445dd89e3a08902b5cdb356dfdc24b0f92be5215d"
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
