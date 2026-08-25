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
  version "0.5.873-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.873-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "381d4021a6050b6eb329f54a60a861d0b2be414b6bc9a427ae25416855be063a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.873-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "669ef706a87a4a4f30e9ead6e54a14749db0e2c6b1fd6fc6c1d4b2981f22ff0c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.873-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1723b7408035bbb6e24d56d72225cfae0ee2dc8dc27cf3f673ca476b1879b7b2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.873-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2236f35a1f3c4839acc477ba686dac37d544efd422db5552a74ecae48e24e7f2"
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
