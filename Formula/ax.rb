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
  version "0.5.216-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.216-rp/aarch64-apple-darwin/ax"
      sha256 "74e79852296a66912e3bd91c2325c68ca29c06a820fd54aa37af67f1f0b074af"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.216-rp/x86_64-apple-darwin/ax"
      sha256 "afd6d99c9fdffc17dff5b5080128f16a67db4aa5a5343043e2ce1af6a51e681e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.216-rp/aarch64-unknown-linux-gnu/ax"
      sha256 "4062db14d7400db7fc172594192b33917a06c657bf283219b81fae518760b63c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.216-rp/x86_64-unknown-linux-gnu/ax"
      sha256 "f9c42342ef9ce33c9710cc1977ab13ce6d3c126ad491402905a683ff4e590242"
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
