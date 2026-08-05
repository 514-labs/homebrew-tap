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
  version "0.5.658-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.658-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "5f93cb15974bce4aa0addc7d681cd09603eb3e28692cfd571aa06832f7c59811"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.658-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "c21141d9437402faf351cc80c64d452e6c7ed9d939f580b6f529fb7132f2dab9"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.658-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "25599a6c065f43571436935fd1c3141f1025999ddcd1cb5f618f7d5d0bf0b45a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.658-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e65e81b639fe8550f98c56b78c5f1ea07d9dbab9235eaeabc9f1710840f589ba"
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
