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
  version "0.5.923-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.923-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "8c155d2464a1257f739567fd5bfd3ce115b502262a12224f9ae4a53062474b1e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.923-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "3c445bf20b4bc49dde595459c1387d37ce1f81ddf4c1ec57b7520bc0decab07b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.923-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "bd2042f9e4eb626c80fc8cbe2b77060e71199017e0faf949dfba0db956c2cbb4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.923-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5f46346bbb4b07c147fd1dcdfc93b55405bb6cf06bf4e0b1b697c5d09b14211f"
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
