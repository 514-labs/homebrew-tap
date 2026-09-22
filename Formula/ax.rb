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
  version "0.5.1089-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1089-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "2dfd8f5e68cc082e411913221a84de779c0dde4c99fe48bd2478524aad8e1d77"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1089-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "7f792046903cd53f68992593267ca11ca5d4f6cdd44300227a209961aa88dd6c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1089-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c53afe05f263501def20861c498c20d2726de3c08ec13a000bb1c8e79c71d8e8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1089-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5c1b5b85f7e75fb4b8f6b83f3499ab774170a3d92999c88e5e21a26829988123"
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
