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
  version "0.5.1522-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1522-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "19c045937936e79003a356bfb7b2be50e33e783480b74ea8f04813834ebbe92f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1522-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "e21e1ec3e731b704c41a412d03fde2b5d4a351fd0ece5f890907bf0d9cb639a4"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1522-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "c8c91c5ae076918e05fe364101deb92a10b4121c8e3364023cd3e429cbe966c0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1522-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "99c0f24c9cc2d9e22ed8b0d87fdfe8acdd6368a695741ab0f7f44ea06ba2b82d"
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
