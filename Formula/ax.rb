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
  version "0.5.741-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.741-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "5cb27f0bec8f08055d055d8911c0da523d5fbdac2c290fe674ca60712f23da20"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.741-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a371147d91a4185e7c4dba43d67a690895bd9d968ff115ea44ce06320550174e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.741-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8e0209f08c5114b565fbb5c793e8e99f920d22f10b40016ad291f691a9d2ac4b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.741-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3544a5f9827c1302ecb7ba4d035efcc04d844c6a087721245cfa2c439675c413"
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
