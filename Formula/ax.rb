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
  version "0.5.640-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.640-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "053e7d93055952dfa4c034d180074fd73b10d4b7380dab2800d2453f0eb880c2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.640-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "dec778e7071cd03ba222211b2af6cf67c1dad9ac74d31cf678561f78a9864b46"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.640-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2eb32cc11481854e69a4501b6109b8c3b370ea336bbf2539131920a8835f694b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.640-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d65c000810a7a92fa5304c06171f703fbe1a6a279f732577b58a3754c8b08c27"
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
