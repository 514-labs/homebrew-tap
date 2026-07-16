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
  version "0.5.235-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.235-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "a36f40a72cba2835a19e497efb3fb72204e3dd8fa5cbeda5c6af4d729e085f0f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.235-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "1af6d48fd415fe3e10c5b11cd1efe4913e5f5aad071945dc9608c7ae919b61ab"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.235-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b1c67a5eac2e5df60187655d30ccff3a9ebb31ffea62bdd9196e576287fd9d92"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.235-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "1b9944c6401d00494fc372bb0c54d03379dfa2a7a9539d1cb74a9b8591ba9d92"
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
