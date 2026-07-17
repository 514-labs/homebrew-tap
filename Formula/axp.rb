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
  version "0.5.253-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.253-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "15475ed8be8c54915de92fec677c7a9af9771719fcfca9c1165378794a08dd1c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.253-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "c64706c19e14c4ad37207e0f1701f5107bee364c0e28a638793c77fd104acfe4"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.253-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "467508807d339f21cc5ddc3e1e7b81bb8396bf149dbd8a367422731643d7e1f9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.253-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ea7c81186ba3b8cc09a08b7eebe1006f5d02cb22d22d9cf7a3388cdba7624085"
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
