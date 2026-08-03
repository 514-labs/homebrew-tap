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
  version "0.5.625-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.625-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "ab96cadd49eb23ad13c698ec9eb33283c18db407ebbc415de7eaf6c85fbb72a7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.625-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "e22bc2935dc780ee55d68376ae20a297fc06cc00551bf7ba0ad9b3d2cce88584"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.625-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "664bc957b2999be239752bc3e5b7443dd517a150e886e125311d7a5ae2ffef73"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.625-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "fadd29f8a301b47c4df614dfb36c358233f3087e8739d4ac9fbcd5f14645eca7"
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
