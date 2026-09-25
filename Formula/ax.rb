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
  version "0.5.1135-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1135-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "324ed94ea327faebed4eb6e586765f44ccda615ca5d011becbb24dd95e7c316c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1135-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "8a9b07f38a6c36bdc91dcb2a23d408aac9b70b4c55fd1b5ef7c3a50c30b29732"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1135-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "20d6f0603b9e5e01bac1ab24100f6b53fd0d059a60165ae13f11b9ebd18e5602"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1135-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b84fff525eb6b839c5c92a0557533deefa45696cb78045ce7541380a7f7f5527"
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
