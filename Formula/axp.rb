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
  version "0.5.1275-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1275-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "b8e16b712257331b9f0c4d90eef8aad178df22c4028b7f94a0102b0476b12024"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1275-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "f661fa5b6958335e31d944b74f591221e7d5a1bbde62b5ae5615d7be38dba58c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1275-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "9773634289ee926df29e16ffc620f59b01fcdd1640ec87a92fe4c43734169c29"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1275-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ce170fb65f64622b0d9e5006d11a6e2ce6e8f8f5b099e1091582c46d2b15f6ca"
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
