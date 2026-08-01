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
  version "0.5.584-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.584-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "0311f796e0e70ccb8a5ab46ba66b7fa843425b6ede706af6463b3bc80c9b3390"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.584-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "9f9c8336635bf3aeb5b3789ae7b8777be7cf47826e929c15027ca84b7705b9b1"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.584-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3f1651204f7617f0511b71c5ab5242abe91d7775e767c605c428a140b399f176"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.584-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e29b9c59f85ff77efb82e133401e9edaa90b8267dc37b115cfe9a1ba49e672bd"
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

      Next: walk your first experiment with `ax learn quickstart`

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
