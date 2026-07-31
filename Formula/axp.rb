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
  version "0.5.556-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.556-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "4434e2d319e31bdc8bcebc0325753ea946cb993243fb5fff0298e6593d9ad56f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.556-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "f86edc0c91250ccdec17ad088258025cbf0ce9cd6effbdb84602357d42ad9118"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.556-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b19cfd84fc2ed271a856f7615e0f7eac87dbe64a4ff60c04064527ffee55fa67"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.556-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ef49715d4ca6d002d40f7dd137c48d45699bd2dbae18de7fc6c75353bd88f0bc"
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
