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
  version "0.5.266-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.266-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "c8ef0eaceda5051943884995b6cf2ef4cbf481deb54a2f5357097765006a80b7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.266-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "b38291f8470f96f087e4e94468578ef9478fb4ff0ae86a674a45aae3a46ee7d5"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.266-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e1a8399690a6f7878d144477cc93b7c98a9d5fa081039e5f9163c705cc6cc4f0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.266-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "70fbd936952fac44d149d95c94da630edc371f740ddede379c1aa3e5c0611ff1"
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
