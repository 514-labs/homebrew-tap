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
  version "0.5.1662-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1662-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "8c6e0b4031ef14d5dc355f0aa1cc628c12c393cb6ab6a7b684827eb5b87c3978"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1662-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "3a2ef856aa249170b429b92c185a800c82ed490cd61fc584bbbbebd5ebf619de"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1662-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "e11018195146683cc778b39ffb6f839adf9931e53d007332af894a96fb898add"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1662-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f1ba6bf62d245a495b2ebc81790d2665140f95f309778c335809d520d3aab2fc"
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
