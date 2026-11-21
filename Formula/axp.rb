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
  version "0.5.1780-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1780-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "5c73dd47921295ef24cd0b5e10fa258e7bf9191ed7d96032ead6d7a874051988"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1780-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "d5a0e02d4dd83f9e6adc1b49de9d8f0c8af546cd29de4c4ad7005c2685431a3c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1780-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "58a4672320aba28f8f35f0028ff3ca286a9c94399a50e927d90d541d0e7154d9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1780-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "8e981d763ca2ac9830f1c7ff74da3e6786d75f8cb7ecb245595f3abf5bc986a1"
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
