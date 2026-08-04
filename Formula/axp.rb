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
  version "0.5.628-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.628-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "09e0edcdcbe2b1f7c286a6d6bef0e6b4329f7847a4d88e983cde79a5eaabb95c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.628-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "f67089da11f2ad14b61ee69eb16bf9432ed9fd7d622cfad1ec636f2162e4c2f3"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.628-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f1a5d1b7ab915abf4e52d3280b14ca9e453d26c679d6b8b8f9718f7f8489b6e4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.628-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "0d7c1875c6b9eb059ff464f92003e945ca56d4cdffeaf76938c67c6188f36735"
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
