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
  version "0.5.787-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.787-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "f2bdada27c9114ce66f360b95c5f24b4752c7755a82ee9d50be8c5f97f03b5f6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.787-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "b48d49c99ae58c0e763bcddd5a89127300e7dfeec550b6eee588303466f9fb5c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.787-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3f4d357c9a19ebbdc286602836dba27e220e0dbc2a1fc9f945ae722c3dc9ad77"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.787-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f953083079b0311b01e20ec7d36e74a4766c14cdb46413ad1e9f08f0d0a3eddf"
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
