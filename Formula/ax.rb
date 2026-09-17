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
  version "0.5.1064-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1064-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "b34903a1fcdc7cb4cba3a661a9f98b02aaf3c7caf6d5267e229a58464b267284"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1064-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "03a53924714bb5611db10e1b3e88b7ccd8ca9d1be2f1b8c13274988614cba424"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1064-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c4004d1b24731157f275422e5afe724e12842eb8083ffa162a9916d65e2eaa15"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1064-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "7d30f85b7a2eedd3c58ad08a2a316727220790c2ac4925786da074c9c19eb113"
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
