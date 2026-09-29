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
  version "0.5.1173-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1173-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "7b8e8e3efdc00aa6548685406c98cf036a4cf7280ee7c9ad48b82e9ac59f4e02"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1173-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "6c1e195a515f0b86a81f4f712df26e2706f817c518ed82034e534019b2b21da3"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1173-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "063422547dca206f5ab0f0b252a2a8e35448ffb91580a05809f046fd9a077290"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1173-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "24715f76c8df0ba4a6ce3575ad873245c7668792b365f98e3489f678181e784b"
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
