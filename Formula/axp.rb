# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `axp` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
#
# ENG-3612 deprecation window: `axp` is the old name for the `ax` CLI. This
# installs a byte-identical binary that prints a deprecation warning on every
# invocation; switch to `brew install 514-labs/tap/ax`.
class Axp < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.571-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.571-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "9c0b03c294fe9ddd5fed23276b18a48175f0db682ac52f60738a6dbb933c0614"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.571-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "a3c5820f87c953175bbcf173dc33df6a067692a253e7d004d8f024f1a32a5e53"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.571-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "273073c69c95ac54826a8dc7a4e4d8208a2c07780e61682963f5230d7a311832"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.571-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "960a9fcc1d27b04997e32bd47152cd939b14b455219b4e776bff9f6f450d8b74"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch relocatable archive
    # (`axp.tar.gz` = `axp` + libduckdb sidecar). Install the
    # members into libexec so they stay adjacent for $ORIGIN / @loader_path,
    # then symlink the executable onto PATH.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"axp"
  end

  def caveats
    <<~EOS
      Sign in:
          https://app.514.ax/sign-in
          ax auth login --token <token>
      Then get oriented:
          ax auth status

      Next: walk your first experiment with `ax learn quickstart`

      Already have experiments? `ax experiment list`
    EOS
  end

  test do
    # Keep the smoke test hermetic — `axp --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    # Clear loader path vars so the test exercises the archive's rpath
    # ($ORIGIN / @loader_path) rather than a host LD_LIBRARY_PATH.
    ENV.delete("LD_LIBRARY_PATH")
    ENV.delete("DYLD_LIBRARY_PATH")
    ENV.delete("DYLD_FALLBACK_LIBRARY_PATH")
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/axp --version")
  end
end
