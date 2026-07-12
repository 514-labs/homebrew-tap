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
  version "0.5.171-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.171-rp/aarch64-apple-darwin/axp"
      sha256 "29575b022374cd9e3906e3720828d9b7eede00d03ec406379e22037e63b45536"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.171-rp/x86_64-apple-darwin/axp"
      sha256 "67aea392e68d0c138c5ea43e012ea23628ec7a49da6837e31d12ae99e154adcb"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.171-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "87b0c2c28935864ca124709abb5e57db4562471da89516cdd533408ef7802bb6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.171-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "f005535141ae0d5f7ebc70a9ac41101f23ae7afc378010c04eb2b0e31f56f92d"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch binary, staged as
    # `axp` (the CDN object's basename); put it on PATH.
    bin.install "axp"
  end

  def caveats
    <<~EOS
      Install MCP:
          https://docs.514.ax/docs/mcp-install

      Request access / sign up:
          https://app.514.ax/sign-up
          The AXP platform is currently in closed alpha.

      Sign in:
          https://app.514.ax/sign-in
          ax auth login --token <token>

      Author intro experiment (CLI install test experiment):
          ax intro <name> --cli <cli> --target-description '<description>' --install-docs <url> --install-command '<cmd>' --smoke-command '<cmd>'
          ax auth login --token <token> → ax experiment validate <experiment.yaml>
          ax run [--variant <id>] [--repeat <n>] <experiment.yaml>
          ax query "SHOW TABLES" --table

      Docs:
          https://docs.514.ax/docs/getting-started
    EOS
  end

  test do
    # Keep the smoke test hermetic — `axp --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/axp --version")
  end
end
