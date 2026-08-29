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
  version "0.5.931-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.931-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "959a071666b56da0e95e47e06d287f508901a65e233fade6700b62cd6626e9a7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.931-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "c4330dca1be217fc1822b67d50e12e218ff8a5b494ee9190828bd9290440295e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.931-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8619bcd4b9cf6c469774bd63d1a6dab72d148bd68d47d5b29b1bbc52c10c3145"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.931-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0503084445af95d1095a6db2cb52f5e5793b5f346c4fe116089accca6e9dbc89"
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
