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
  version "0.5.1797-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1797-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "67fb3908123a5bc56977672bb59e2e25602a03f200db511e359b16918a9c6945"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1797-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "c483be48733fafc6942f1e4afffb366918c304cf22ffd4dc6707abec56e5b867"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1797-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "1fe667c584be9c3691b7bc196eb524d0abcbd8f0cc4d13503a0def8923e52f2f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1797-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "237006e53cf4de984d112476bda71a9a1ffd56c409b0cd33d89b5dfe24781805"
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
