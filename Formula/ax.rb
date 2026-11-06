# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `ax` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
class Ax < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.1650-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1650-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "f6dc8a29e83e1e69180de7b86bcfbcde849428f31139ad0d90ca4437da505e98"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1650-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "411828850eda01bc2de82a18f8b58ea19b74d11b8cd8517aa09b9829cce21819"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1650-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b253b03bbeaf2c7880f929927807174d77fe88fc61d4337790139c754af582d3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1650-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "797500f477e8e002cf2b22e4d490f828696cdd0b18263dbaeb6b92589f397423"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch archive
    # (`ax.tar.gz`), whose only member is the `ax` executable.
    bin.install "ax"
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
    # Keep the smoke test hermetic — `ax --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/ax --version")
  end
end
