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
  version "0.5.1444-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1444-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "d2f4830974a3440aac1fdc406ea534b30b090eb962cb39fa176bdd9961b0963a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1444-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "c52d4b74600c7ae1d11a737bbaab824e986e98bee792d294aa55a154c4f9f256"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1444-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "fa0509b638a5a29d0edd340e8a807e6b187f8fef1f2bf1672e371a6be5023b98"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1444-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "55241e23d143f471c60a860160a014eb8c14b0edb35b62c35497c28e06f23e67"
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
