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
  version "0.5.607-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.607-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "2d3eba34a511a0b341cbeb639198f74b02780b61b9e9f5af5bc03a2b2ca9ea99"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.607-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "c4f0a6db94ac6e6acbeda4ded780ce171aa07f05c7caf75fedd328d5c427a2f2"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.607-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "aa9303c6043e36cd2e978e3a49931b0d8b7d3c9646596ca0507a7e1d18348664"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.607-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "04b73c4f72d283339dd1ebd20e11a381100a33957bb9c27ba714dfbbfd0d1c4e"
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
