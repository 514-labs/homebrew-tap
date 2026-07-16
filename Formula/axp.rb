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
  version "0.5.240-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.240-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "a0516eaad40fd73b777539592d0e3089d02dd634995434ba6ea5f81b8a365f49"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.240-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "b2b45d441479fb96e88b757b55df9c18b6930df64e4d9c490d8203b09b5da205"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.240-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ec8c0f27508cfaa2d56f76b07dbd2d64abedf85b50e66703b903cd06f55f9d94"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.240-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f77d1470e3061e4cece3167f0010ba1b495fedc5e1cbecaf4f876fea6c8c4792"
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
