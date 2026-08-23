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
  version "0.5.856-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.856-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "fdc0b69d3f0c669070adc6f426b20ad99292c522565d7958715415d82d2a1d11"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.856-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "29ca8e9fe3e24286db2f9d98f125acf5f47a96cf1b3f4891cd84873cc7bf01e5"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.856-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "819152f5d9406a667a03ac13d35d62b12e39edd271194215fffbd0c42dff186c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.856-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3e45e7a0e24d0999789d9484844b58696b61e9346e0255fb3915bd057380731e"
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
