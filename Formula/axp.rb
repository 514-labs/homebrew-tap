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
  version "0.5.1329-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1329-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "86f4aa81bccb522c4cc7254b6f0c0d6d396a128e142821fb2e8003cb2b799b87"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1329-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "f7318234d9196661dc9c0b3ce70c5e333d1bb9e625c1bc6e30a631a4f8ecbefe"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1329-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "04da200b7b5b7f53104a2b2c97ac2ccf197a5f36c609585056874e91e2322b35"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1329-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "c5b4bcc39f7fd12976bd68dbb4fc7043fddebf4f6d576105ede1499161780098"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch archive
    # (`axp.tar.gz`), whose only member is the `axp` executable.
    bin.install "axp"
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
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/axp --version")
  end
end
