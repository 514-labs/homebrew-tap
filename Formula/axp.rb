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
  version "0.5.1313-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1313-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "1ac66d5a383f016cda41a16219d79bd3ffed162256881ad87f868722d1ea848e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1313-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "c3b0cc20e8faa5b432279b6fd15d36c8aa901f93c9a8c91a5892afd19b7c630e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1313-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "7b4a0a53b39528f3e3569fcbc8bbfc9f8214055e29269dfa33edef3d0ca64efd"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1313-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "13d28dcb38bdbaa4a63c648a1fc0421fe970292a0a801a24f5e0b922e94d2803"
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
