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
  version "0.5.1789-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1789-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "767358dbcbe641ef68d3de910a8d09b2dafab2c8176d419b9f97d92bd121b5a1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1789-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "7e87a1a76e4c90f623b8203027f81611019610624141253e3f2f2e187273fe16"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1789-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "d02baeeae37307d7143553755aac565d01718ab53add9ea29c4e6b3bc9acc0b4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1789-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "d595253ea7ddc29e187f7ba447c75b66d13ac8ec00436598ac3e2e2ffd5bc7b7"
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
