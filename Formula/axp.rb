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
  version "0.5.1726-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1726-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "3e446eb2800d71d6f3a19dd064269a4b84fa9d0b80b56383e9fd6f4ea5549feb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1726-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "2fd5d4f7b61d7c3ac0c722278387d15cbf0708a965e4a6c80cb9cba1b865f555"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1726-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "bd8ab83db6449655c4448ab936b0508b04a4dea6774522f10515a819ecbc5049"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1726-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "06ef621bfb99c2d3676c37ecae53a1c24f516eaf672ced8185fc40d2509f35ce"
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
