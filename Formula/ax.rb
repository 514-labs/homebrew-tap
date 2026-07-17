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
  version "0.5.264-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.264-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "97685ed4b0c72080c7f67d0d34d83f41b5ee8f26667eff3cde03622e88d334c6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.264-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "1819c17a0ecb937b6df3d3b05bd8a348b9e4d159f0038a9f229dd96cff8b6ce3"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.264-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "129fa46350351975152f5bf8a7a4bf2b1cca3c16a56f2d0e22c86de258e30be5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.264-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "30dd5eab4de050be33e97fc134743d006c55b0a2ea2ca183468bfcf3b8515c90"
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
