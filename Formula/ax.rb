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
  version "0.5.717-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.717-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "e65770f6f0978d4fd4d933d3c2716c29ce8708c50ab4adcdefc6cdc71387cd66"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.717-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "ab205cf263687cd82f1fe5b0e01bca83d6bd4ba7f9141f8d9efeeedb59840399"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.717-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "75ad7f7a5959fac7e8a1b4d4adc37367e20bdeaa21da63b51c4e97eb5f068dae"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.717-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "84365a13369c1ad596432443946080fdf8e7dd6f5e535fa46cbbb05abf8ea09c"
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
