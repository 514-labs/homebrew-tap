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
  version "0.5.940-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.940-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "214af220cdfd3ef0fcb6bb71ddf166699e9f7a0fe498c5f82b6500d78a049bc2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.940-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "5bb6b3a2a8eeca4f800ec79cabfe9cac063e3f1e16769d4501ffb78b99fb0175"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.940-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "71319c3bec22c9890dfd6631dde2a5ab039e7046bd3933e7c959d09363f83b6a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.940-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "021c34cac6206e27e522f12d59fe7e0e2b729a245dd48284afbf1633d51c0472"
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
