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
  version "0.5.1123-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1123-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "917f1705da2de6a3fda6ce37a02c6f9b953ff0b6d49883ee1a0d9fdf36259d13"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1123-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "3588197b9462df6805d9d6b568380da2bc8e1feee46a7b9e48d885fb1f5ca152"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1123-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "213c35022d600ecf5195a49924638c1b1b5303051b502306a09d0d31a43ee3d5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1123-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ccaf0c314aa093065f3e33442fed3c007b8a574bea272dd998f533cc1e0c106e"
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

      Next: create your first experiment
          ax experiment create my-first-experiment --template cli-install   # see --help for the required flags

      Learn how to use ax: `ax learn`
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
