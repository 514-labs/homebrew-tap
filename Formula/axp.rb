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
  version "0.5.1631-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1631-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "766d1850aff07291a284f5de6c64f868545cef6af7e9a8c17c3238256c856424"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1631-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "e37267a08f555351214f37a6e0495d23b2ce452256758275d57f6521b8206f8c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1631-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "159a32bd89c13e8ede3da2ecb7e544fe24488e05a359cdf6b94dc18ff8bf92cc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1631-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "2301d2dcf44ee4a444455e3031518c75335f73244d662edb7a22928a0d3b0cca"
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
