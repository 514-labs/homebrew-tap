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
  version "0.5.1424-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1424-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "e295fc09b5063cf169220a222dede0c4423a7fc45ec45c7050706a8b9b618518"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1424-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "8fcdc69f652c2003a7c9f37518807851ad27886b83527f6268e95e97f3728230"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1424-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "766153b21e32474ab2928f58861b5c90a9391a4055562319cfdf61d1d12480ee"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1424-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "3833f394305efe9b3b6cff3bec6987abc5ac28f3c21d0111d650080dc356d61e"
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
