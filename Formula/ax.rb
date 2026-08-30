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
  version "0.5.943-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.943-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "7ed550eb6441cf9f7a32e2eace6a79bac525d44e5c2a77ec13266579e2265bac"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.943-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "9432a17013a00783036df1ae1c1eee496b79fb84c73a54d85e934d3ba122563b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.943-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "bb6cabe72e5f4a7671d8c97f09c7c191e3424b6616bed3d139461ad7a975a3ed"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.943-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "debacabe358fc6989ee84cf5834e92cf756aa047ba6bc095fd9c4a8f03390f8f"
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
