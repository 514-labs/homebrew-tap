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
  version "0.5.559-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.559-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "da3a5bf6d06cc37894984bf549f6447295d90bf3e0b9a611cfc6494d2f1fbac2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.559-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "5a34c2c2def0a96de69591dac4a3b258ebec3523a248bc8753594c5ca72bbc2a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.559-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2617f4246bd9b5be46e330e966f4e0491f2dd09eefdfc4b4ac8653687382edf9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.559-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4ba122edac9d88ee54764bbf1b19d09ad0200f54933a4e4b28bde6df68d67818"
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
