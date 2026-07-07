# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `axp` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
class Axp < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.103-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.103-rp/aarch64-apple-darwin/axp"
      sha256 "f93e3873ff8a2c933ef6ab1c53a5cdb624305d1f41687f709e1e4bc7d058f7a3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.103-rp/x86_64-apple-darwin/axp"
      sha256 "85275a09c06c2e3533d59ccfeae0cabcc085829cd74917202ba5f5b3a3608c2f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.103-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "d58493c88aa39970c228466c04b8df1532bed6c8821b54a356ef06686e52f1af"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.103-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "96cf17ca72096c70ff0602972ae4612a57a7ff91921b8dc4aa510f0d2aa2a088"
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
          axp auth login --token <token>

      Author intro experiment (CLI install test experiment):
          axp intro <name> --cli <cli> --target-description '<description>' --install-docs <url> --install-command '<cmd>' --smoke-command '<cmd>'
          axp auth login --token <token> → axp experiment validate <experiment.yaml>
          axp run [--variant <id>] [--repeat <n>] <experiment.yaml>
          axp query "SHOW TABLES" --table

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
