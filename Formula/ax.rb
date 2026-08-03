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
  version "0.5.623-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.623-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "961f7339bacfe427a98d0e90e8fcfeef9c2648d87686ec75c9e189ceda1ff472"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.623-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "322ca3fa378bc407fe5f81093b5499a8306115a68a1c7100198cbe4c9eb3abdd"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.623-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c1645860326f5ca665d35af547ecb9f04a290b0af5592b3915d2a229c28575cc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.623-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ce4b1912fc152c1cc76b4b3866f4fe340e8f788a49e2eece721786eeeebd6688"
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
