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
  version "0.5.1659-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1659-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "d1c2fa7ef77a84abfdab1ae8b7feee048c1d863d072b178745dbb20bcf88b767"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1659-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "d59377147e2d8bc919bf1106b6a49abe5215969ef76efa19bbcbf9b89c7b993b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1659-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "dbd89cb666d70488bf01264b61b678bcc7b6d353ea31738a41fc3aaed72c6bc6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1659-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "0db8d9d77a720b18b86e74313c5ca6cee5bd9455ec605ae9711cd04b8051be80"
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
