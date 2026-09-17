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
  version "0.5.1061-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1061-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "5d7b64dd64212341673b8eb9649a65308713ed6338b1a4946ef8c116fbb50c76"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1061-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "ae2eed48b488f4f12bf8c68798b7e753fc72dd4ac26a3bb6bf290b8fde6eb8fc"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1061-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3e438a29f52c1e2baf45e298821930738df30f31d9657cfc7984b2608a5314c0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1061-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6c6330d192b196a8ceaf1e47a790262d8774093b0771cac2bf0517bb6178554e"
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
