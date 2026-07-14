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
  version "0.5.200-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.200-rp/aarch64-apple-darwin/ax"
      sha256 "a9d8ead36e6f101516e08f4a6825e802ee0d9ada8e3d3bb21500d910e13c5930"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.200-rp/x86_64-apple-darwin/ax"
      sha256 "dca2265d53bccc9b56ce0e064ccb2ba690186b1c79d486442e17c4d8dd2f3624"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.200-rp/aarch64-unknown-linux-gnu/ax"
      sha256 "e3393042d710615a6ddde05be2bc4ab466d85d447f4fbe78b03eec80fdfdead2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.200-rp/x86_64-unknown-linux-gnu/ax"
      sha256 "49dc17cae45c0586c5b250dd7bd2170edda9ddf35618e53e120207ad7fc12882"
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
