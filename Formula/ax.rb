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
  version "0.5.671-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.671-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "1a5289ef5e48b36c9ef96c021bf56fcc8fea16b73e446c562a57d238cf08bd24"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.671-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "98201c5e54b32ae3fcabb3869bfa1071698b96f27ad0ee71853045a105c2ddf7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.671-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f75d77382ed6c5b16da5c9df994356615c33532ef0301d676f473a47265405d5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.671-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5578cc9efd21e7e5e0121453dce3e24522fda76d56da1a6f674223086c23bcbc"
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
