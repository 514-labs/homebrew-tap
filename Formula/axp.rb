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
  version "0.5.819-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.819-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "d9795aa2c73e0186f87d6b2f6d7b184f9a082f6ac0861bb2a6941c336edfe36c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.819-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "b5d7458b7c58aaac9671372741c0b823b1a9e2f9992c0c3c8a1d9428d377f0d7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.819-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b2cf9849e86d59a6f67c84c4ee1ff7646ef98addcc537247e30f5ae6c954418d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.819-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "20c6f244813a261471cf086ee7920870315962b7e6285f5014ddacd2bccd4b10"
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
