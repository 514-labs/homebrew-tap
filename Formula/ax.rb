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
  version "0.5.774-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.774-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "a52a3d1e2bf9f21dad387190730897af86ccb2b57b4a250a2f871ab6284ef978"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.774-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "4f3341a8bfc6820278a61990d64df6a205bb300c0896ce94d51b139641af8fff"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.774-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c8c52c38d4b954efcb63a4b8375ae4b91c3d68cdea15831f4b506aa1d0aeb1da"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.774-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "796c5d54fb3ce1e8c7757ebb6dcc058335a1ed487b7974bc71af3ae19b08f71a"
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
