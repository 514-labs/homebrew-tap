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
  version "0.5.1070-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1070-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "fbc85a1d93637e1ea9035aec02ae295486c28d981b2c46e34a53cfb1a89f3046"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1070-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "e3f937010885d9b111808984162ff368cd81931084ee2d252fb79a0beec1846d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1070-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "980d944501fbf6aea0a329d04b11073f4aea46673524521772ce36bf74eed8b9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1070-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "c710c11e7c0d763fff1ab1d08e85a7cdd9fc244ea94c43cacee2bf8631d53f29"
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
