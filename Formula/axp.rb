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
  version "0.5.1383-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1383-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "98d8c990ff7d31f7a31ee8985b197281dbe454b913c357686775f2e721759d53"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1383-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "0be3fa3ee53e0a16d88dcd9f3c858d9ea4c61a8b4698757fb01e2ba80496155c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1383-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "dbc21d4314ee7ea69053186e7f14242032f79294dff498d185a1f86011128953"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1383-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "8c84e481a8e21b86e06896ded469efdc72a053198e7103793810ae641ae9e039"
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
