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
  version "0.5.564-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.564-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "323eb8bd2ee516cb0e17f4fcdf36dc26b1af92b855d29f5452215d229fb7c158"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.564-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "5150a1459459cb3a1777737652235a2a7b349aa5460abb46cb84ad5402cfb25b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.564-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "bf0e55463e1801619d323a180d1700c4231e62310893c1a2b97990abbd4cfa14"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.564-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ba43a33fc4bfbef686c96396755d922a1f35710311f54df333ba2bc182ab821c"
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
