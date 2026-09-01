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
  version "0.5.944-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.944-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "6abd4b66733142e2315eb844dad65ff723dccf2e5e6547583e4be1970eb7e2a0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.944-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "8c658def27eeb6a621e268d26f2cfe939b67c82c33d105d37756e0414793082c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.944-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "47473c44a20d3839df173c19cb34687d5402a0855ff585fd3d54b4b6beab0438"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.944-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ded80c10c5ad5225a8801c56c2549045e59d7e50ab575ae242d595db9a1568dc"
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
