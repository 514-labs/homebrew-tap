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
  version "0.5.252-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.252-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "a56464fdbe19e012f92c800e1184cb33acc68663edd81f971abc4010f55759fc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.252-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "6bc0bbc58cfd2d429eb37301d85d0248226e69f2e1d97eb0391bc01ff8cd88b2"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.252-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "cb49c85ad57d0bfcc68043d6c9f67b2279b537017e3072dcc8c9d5f33e3b3420"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.252-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b1a45cc21a83686094cf1876dd6ac28337753120943358be3fee6c1f194b57be"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch relocatable archive
    # (`ax.tar.gz` = `ax` + libduckdb sidecar). Install the
    # members into libexec so they stay adjacent for $ORIGIN / @loader_path,
    # then symlink the executable onto PATH.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"ax"
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
    # Clear loader path vars so the test exercises the archive's rpath
    # ($ORIGIN / @loader_path) rather than a host LD_LIBRARY_PATH.
    ENV.delete("LD_LIBRARY_PATH")
    ENV.delete("DYLD_LIBRARY_PATH")
    ENV.delete("DYLD_FALLBACK_LIBRARY_PATH")
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/ax --version")
  end
end
