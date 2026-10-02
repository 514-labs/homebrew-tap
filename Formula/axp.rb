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
  version "0.5.1243-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1243-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "072384d833364b11f6767a498bf4235b9d97add102906da96ac7e3ac6cc695e8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1243-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "e8e160842f4c7b342103213b53a50259bd64c334f1f6eb8596eebcf7ffa8f12c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1243-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "528f541e53614a2223aeabd69febb61b21d75ae92a9d2ce5f7b90402e901bd61"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1243-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "9f0fbcf97cc645a964cecd3ea7d58ee5cd5f1582a4b7c19f558682291a1d391c"
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
