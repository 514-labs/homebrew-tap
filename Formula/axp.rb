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
  version "0.5.838-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.838-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "acf07004e4f9b7441926be2ac6aa6c15ebd3f318aebae28e3a0f220e8fb34ed9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.838-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "4d871bb8bcfba0051b5e7631db97b555d788c98970011f0d8070c89c5fd1afe6"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.838-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "942c7381d3bec018b1b9a34a88cc41a2a7c1546d6b0fc223e694a499d283a619"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.838-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "74c7df78a60020d52b1a0c376fa0b6254020ccb0a72eda497072da0228d82ec4"
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
