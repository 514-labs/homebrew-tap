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
  version "0.5.266-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.266-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "1f606729f387ead42ae9378e634eb2bb0da971dc910185e0eaec1f74de705262"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.266-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "c963c8f91f9a34f15aba9383a16f7834dced8007bf64ab8fdb0c02cdbb4e0977"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.266-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "5de179577c9f2fc78c13ae482f0a3b0a62265f31e683f03b830516114b456916"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.266-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "36aa220b4721da8d824cd98bbe715c8f0cbf9a7b32b1330b8869c2758d23a6c3"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch relocatable archive
    # (`axp.tar.gz` = `axp` + libduckdb sidecar). Install the
    # members into libexec so they stay adjacent for $ORIGIN / @loader_path,
    # then symlink the executable onto PATH.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"axp"
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
    # Clear loader path vars so the test exercises the archive's rpath
    # ($ORIGIN / @loader_path) rather than a host LD_LIBRARY_PATH.
    ENV.delete("LD_LIBRARY_PATH")
    ENV.delete("DYLD_LIBRARY_PATH")
    ENV.delete("DYLD_FALLBACK_LIBRARY_PATH")
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/axp --version")
  end
end
