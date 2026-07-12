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
  version "0.5.165-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.165-rp/aarch64-apple-darwin/ax"
      sha256 "524afac056a49d74dbc5ef5734a455fe549badf40a5bccff81f214a66d200836"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.165-rp/x86_64-apple-darwin/ax"
      sha256 "2ad333e1191e0a061883672772fa7022480cb6aeb3842a2da426e06278ced63f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.165-rp/aarch64-unknown-linux-gnu/ax"
      sha256 "d216918f9ab4c72ca827076904fe050258ad9d760c3a259b9bc722140f3c55bd"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.165-rp/x86_64-unknown-linux-gnu/ax"
      sha256 "f1fb2f72d1e515983537e512df3a368f37d002f8404d7b81919872e99a39dab8"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch binary, staged as
    # `ax` (the CDN object's basename); put it on PATH.
    bin.install "ax"
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
    # Keep the smoke test hermetic — `ax --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/ax --version")
  end
end
