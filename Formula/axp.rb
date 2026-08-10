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
  version "0.5.729-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.729-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "b5dcaadf11b80ef60162d3e0aa6041f7b227cd3edb6de8a7af759ed2c6bcac29"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.729-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "a9b9f42e7b68ee31b4ef772cb40345cb077fd8b5411a26b827b558cac7c417e9"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.729-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "bce80e46cec04b2350d356c0934edcd20c847e2cfb6c16509cf8d3347aaee00b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.729-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "8d2e1b454ab4ed4e29f9dee3d46a76fa7fa7352bf93fab59c03237e27ba6ab41"
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
