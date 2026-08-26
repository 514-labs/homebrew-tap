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
  version "0.5.890-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.890-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "86ceef3cac9306e3e8855f425e2ad60235bb3da0e124e5d51500180db1584ae1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.890-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "e405ffaa6b223fcf3727071969e89c5e7576c8f210f74cbecb7355ea56b4cfe6"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.890-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "483610f014ce062eb02a5d9cb010de79c1a5883a7e1e4a32fc9ec1d64d150690"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.890-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d413b7c562bfc2218f81966e0b58db11138a919313faa60065bbcc8a930a9912"
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
