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
  version "0.5.643-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.643-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "629332b2521cfc2bef6af190bcaacfd32f139f235f3ee0877d0f5b3a1b92b1ee"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.643-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "3a004828507cdee8dd8019eabd3a3f6fa223e4f7c3a95e4984f3331f87f2fe4d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.643-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2ea7fcbbc5bb30362a6b97bcdb51a09017c3063b5ac819b210a8b376a7be93a3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.643-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3ec05ffa50c8631dd75527cfac3844b3e57bc955c83b96440655b6aeb74739d9"
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
