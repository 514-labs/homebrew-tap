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
  version "0.5.1463-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1463-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "6bde42de4a8526b346bd57d3deaac7441c490fda8aca57b238234da917888068"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1463-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "1785f805bd4761983032556745c503973773dbb6655e90cdd96b0381f6d52af4"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1463-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "9cc62ce1dd9e8fbbf6879829cb2c6b0695ac294e326dc54a5704e3032e9801aa"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1463-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "45143a9d36f391f7faae26c880d0d82c74b5e70e683e3d19166efdb9f815499a"
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
