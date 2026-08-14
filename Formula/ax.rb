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
  version "0.5.792-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.792-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "e7f07d7b2faea209cd37a2861ac0cce7351cc5808a16eb4b32297f3c7c93e168"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.792-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "704703bafe4ece50705fb72a25bc6a2b25b44f41c5dc0c587f1b8bfe3f01e0f2"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.792-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ce2de4a658562b9265f486f05e77e7ef5858194808513c064f38ef4d7d7da288"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.792-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "11137606c125435047f6d089ae1d94cdd843563f8e13dc03e18f0445bb3d2b47"
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
