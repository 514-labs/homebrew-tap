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
  version "0.5.682-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.682-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "d87f5e6df8b1f18e92aac6604e476c8048c8014c5ce7773116dc368c25d43289"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.682-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f2860ccc4b25879054c96d89415815d2f8b09848b0996018422ad906a555516c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.682-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1a73a029b32563863e1a8493527d09ba8645b1b21b918031383432350f3645a4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.682-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "7bcd4da2773411856898f94808d4c8c10307455a552c00a8011bd82db76c4fb2"
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
