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
  version "0.5.898-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.898-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "b223eaf2c3803774bdc6550ae26f4b220b8ffa1bbe00077c1a1e8202122b231d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.898-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a7c153a5eb5e2f83b0d6728e52ae22f13eb4212cac9a2529f4fdfa914ee05726"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.898-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4274218c9cc112a4f02e9c0c3e27fb92e38186cbaf4442d34256e48b00ab720b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.898-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4b9812ab75df8593db2a51b3f16dc3c26e971af0d3033e913d5140489dfaf59c"
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
