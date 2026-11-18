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
  version "0.5.1756-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1756-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "28157385622be0176e9a7e27d10c0c3383cafb83c6ba9d0becbb997b5f7b6b34"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1756-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "181e0de4388323ce9dcdc9e36bfb9cb0e915b367c44649bcbf16e80db221473b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1756-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "046415b560676895bb4a5ca7c781b61a765991d6d887a9431bd2e6776ceb7640"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1756-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "da8893d3b722487b72fb594e03972f226d1c7ab623797734173134ec3113585d"
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
