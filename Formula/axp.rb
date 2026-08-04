# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `axp` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
#
# ENG-3612 deprecation window: `axp` is the old name for the `ax` CLI. This
# installs a byte-identical binary that prints a deprecation warning on every
# invocation; switch to `brew install 514-labs/tap/ax`.
class Axp < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.646-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.646-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "136dbe61daf2e15e93c1ae181933c94e64556d5746fef94c802d284f75b1ea34"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.646-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "078f6849b6d827df58c7b73cd4ee2c191f2a77794d9324ee4af37b144acb219a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.646-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "47a203988d53c7d91cb62537b4b98309bdcde5f2ff48b9b57b01ebd087923f35"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.646-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "93a156ca9d2d0dda4dab9086a179ddc2302c37be7f0b3294c9bc8e7f25de341c"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch relocatable archive
    # (`axp.tar.gz` = `axp` + libduckdb sidecar). Install the
    # members into libexec so they stay adjacent for $ORIGIN / @loader_path,
    # then symlink the executable onto PATH.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"axp"
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
    # Keep the smoke test hermetic — `axp --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    # Clear loader path vars so the test exercises the archive's rpath
    # ($ORIGIN / @loader_path) rather than a host LD_LIBRARY_PATH.
    ENV.delete("LD_LIBRARY_PATH")
    ENV.delete("DYLD_LIBRARY_PATH")
    ENV.delete("DYLD_FALLBACK_LIBRARY_PATH")
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/axp --version")
  end
end
