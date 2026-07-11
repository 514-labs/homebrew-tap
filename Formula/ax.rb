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
  version "0.5.162-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.162-rp/aarch64-apple-darwin/ax"
      sha256 "370e5d55a0fd9b213d9cdc2b1a6163ceafc17ce65d5ce1eebf4736d291a45a96"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.162-rp/x86_64-apple-darwin/ax"
      sha256 "6c64e10fa459c0d61674755e5b3760e55f71b48445c78c974a831a2cc4e28cc3"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.162-rp/aarch64-unknown-linux-gnu/ax"
      sha256 "31a6838bba5d2d1acdd051d432a0d6fa13d0ed94159d1d770c1296fb78275835"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.162-rp/x86_64-unknown-linux-gnu/ax"
      sha256 "8c02a4600ee849d154d39c292262792fb40f04ffc13c0f24160568b9d8a6e141"
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
