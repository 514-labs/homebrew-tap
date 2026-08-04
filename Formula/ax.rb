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
  version "0.5.633-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.633-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "310cf946bd567afe2487a8143b27eb50f2c2a9bcec2f6c6cfb720899e39c2793"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.633-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "4b56b2455cf6030a67da889caf6f0c8df756a49d80c96cc95c06b9b8c0a7ab28"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.633-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "62a8398fc979fcf4074bf58958a04f51c933d6408d2b9f8b1d72e696767c3867"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.633-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "7daef20f6e1a1f8721a1288e3de58c33770e167b18ee0db995556ec04761bed8"
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
