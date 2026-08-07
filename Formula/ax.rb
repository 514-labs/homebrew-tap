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
  version "0.5.698-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.698-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "496374d1b193f1b67e745dd7114233ff44162b5ca9cfa7347fded9a09475eb58"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.698-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "6a0a19a1a23b129733d4904e61947e35d4f6fa8b12dbee2d1809b4274363e7a7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.698-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b057f18042be9f93217a91c3b2fa2973c29857390b5f96d0cefd13f0de7e9536"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.698-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "fe0bcdb6e97f3f36e600677744566d1c73965e0f4acd0f6d09f3c3b60b717d01"
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
