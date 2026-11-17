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
  version "0.5.1741-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1741-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "9fe764e94cbff19bdcc50c5a13f353b066af60b580db34f36133ec30c626d3e7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1741-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "e0f2380b3b05f1b073d74e322d1473af3bd269548b929f1ca289fc0b499bc063"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1741-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f24e2e440fec724cdbd0ac0c19bc16bb46613fd48517545ae5ae5e18775dde15"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1741-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "7897c2cf07c37bab53433199171c5663a872117ffcb61a7108f2005a4c051345"
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
