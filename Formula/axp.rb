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
  version "0.5.619-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.619-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "55e97f2d94c70b347022f3b8d8ce2955c8efa0c59e554e1eb0ef060571cd4a9f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.619-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "3813f6eb1f4de713b0bb8effb39b1a7f8feaeccafe17f01fb0d656de2d5fd7e2"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.619-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "600a5694f2faf82376ae17c5f2a60c5b21058fd5235fe632715b899288d1b9ae"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.619-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "24ca69a858b7238057a992db086bb4381aba39d71960086d2a602bcc550b0c69"
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
