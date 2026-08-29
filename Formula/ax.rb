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
  version "0.5.938-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.938-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "74d3087f21c720326aa6b6a563a41ecbcea17456dd3534095e6f037ab721d9be"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.938-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "78d1e0b60dfedc4b8e5109bc7e087266d61fdde710755cdfc9ee926c29defd68"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.938-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "360ae5362ce4684d0e12d83f60d5b8d7450aeb8742b51975927d9bc3d842ca2e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.938-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "76f76158430229015c8aedf143b386cde3a3ac4e072f362fbb1f66fb8e26f5ee"
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
