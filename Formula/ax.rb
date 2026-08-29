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
  version "0.5.934-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.934-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "62c677a0a02e007bbd52993a600c51ad6304c63a89385f278c4d713d8b3d8275"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.934-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "45bfb4be4621c4140e95c0ebf0208f4ab01edccfd7e1faa276f9230bd88d1bc9"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.934-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "69d4082238d2481775534b35333291dac3b35faf045d99502d306401a0d20eb2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.934-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "38eac1245f4371ed7fb9e36be0a48a5abad7182d8ebc1f63ecbe01b158513339"
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
