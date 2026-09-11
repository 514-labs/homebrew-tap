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
  version "0.5.1033-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1033-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "36e64670201b35b46edea22fa7f586addb1069381d46d8f70b68e35d4f5dfb64"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1033-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "7522a9a4795dd8bfbcd4a1f3a55bf8cd554381539866b58637c81a65c1301afb"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1033-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "37c36378cae6c1863ae0a7f8433d726b4fb63b5df940cda349012ec370ce175e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1033-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8bc1e25ea817b00f540439ca5c69c22371a263274c7fdf94bbb4555526295fac"
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
