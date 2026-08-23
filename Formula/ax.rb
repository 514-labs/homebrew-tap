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
  version "0.5.847-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.847-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "93d6d53a4b70aa507ce5a913477c1351a6c1d1eed22cade651431cbe8f9e65eb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.847-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "22bf68e93d3ee5b10d524bcc600990c72fed807b1044f03e707554ae61af9aae"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.847-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "29772371df28359ca007c74c03093db98cb8ae6e9e1593695be19118bd534826"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.847-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "bca3e76d03cffef04499c26190a2a566e777838d8bfe3d3d51569eb64c36cfdd"
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
