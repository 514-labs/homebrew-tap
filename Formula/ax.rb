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
  version "0.5.885-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.885-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "e7961f3543d6b34e57e51e0ab2feba90bce7a1f1ee6bc08b946ec9793bfadd05"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.885-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "34474de61cfda25350820cba21ed035f835f5f12e1322e04f56d0698e7111503"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.885-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "87c569a30b19c5be7de981d9faf2e4b49ac69efd0c88f9c17e8d601dc69165e3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.885-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "129060b9abae7df2ef25e72d3bd93ba3ebbf1903f8cb3996fac685fcbff74987"
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
