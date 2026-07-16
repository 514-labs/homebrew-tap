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
  version "0.5.233-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.233-rp/aarch64-apple-darwin/axp"
      sha256 "5d73c6747b4d508283ab6a7a84c8371249b138ca60229a18e1bf6f5785d4fd04"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.233-rp/x86_64-apple-darwin/axp"
      sha256 "7ee98620583b9195b33b41b28107ed3faf1ef3c562d260222950120159963306"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.233-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "aa0a18c3f31197d7bde53574615f25b5f8c7db2aae0494a2e79ad8531141f0ca"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.233-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "3f0ab9b361b68e240d2d2b6339004a23e621c6a706ef21ebe93f419a6a3f958d"
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
