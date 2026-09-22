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
  version "0.5.1094-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1094-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "92ef17604c50c50883bb29edcc9b33b44809c02a323ef0f0e18fe8f21c928082"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1094-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "fc6be02772cdbee29c621e356548e27f9c0f565cbddcbef76ebd28c13e4585e4"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1094-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9184da7d8a4379f42cb75e41959c0856a563abf2e747c0a94d9bb2a9746d2f13"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1094-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4b3065dd29fd6109f3857e1470a30dc1b3355a557f5123980b2877ba6609fe6c"
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
