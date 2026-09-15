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
  version "0.5.1041-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1041-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "188b1c30d585a6b3c3f50265dcea92e5bc27ee566e3f34e846cf2d06f217b786"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1041-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "effed7110d1071c5b145a65eeca96b3aceb2b1a819a6385daf0c51e3f8ab45b8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1041-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "16795476defb4bb50dccc9695649bb85e9b88efed548e33bb139765f0141ca7c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1041-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3753d38ab433c05a20f35841ed0594e3224cfae79d0ec166c959431c089e4eb9"
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
