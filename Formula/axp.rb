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
  version "0.5.110-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.110-rp/aarch64-apple-darwin/axp"
      sha256 "667a2641e181b7f346538eb3b3d6aeb38095e3bcdde905d88cbee0c7eaf64065"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.110-rp/x86_64-apple-darwin/axp"
      sha256 "f7260ea65cb97b5b00dc4f41e4fd352f6b9dcd8a15a97ca43f3bbacb34c0fe6d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.110-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "05efdb0d8e8a19eed9cf084328be69a2856bbc25687a5734b2fe0c7b60fa3ebe"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.110-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "ce2715f96b56f38965b93b5d9ecb848ce3db7bd7f5d13b76cc66c62e51f11ae8"
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
