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
  version "0.5.1541-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1541-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "a299c3abf0235bf7c7343017b717be948cab9e38921c41c3906f9a10ec147183"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1541-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "dc5f7365c04591309fd8a8d7900100e2d5e4d9b03ceee84eccb814ddabf83560"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1541-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ae57b0f6caaa7c85cdb69c82f69093b7096ccaf028d9797baf6c10fd9f68b9a1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1541-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "626b696e8e7d53ce899d3d98f609c07176d690c646181ede4f9cdd2e57be1220"
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
