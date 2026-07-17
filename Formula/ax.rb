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
  version "0.5.256-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.256-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "c02b9730a25d6be1f97777496d204da7198becde9ef92fc820a7a15ce96b8504"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.256-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "1add8f011f2a2d803886df79f4d99739d9278c3ab4adaa2702446142c2016e6b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.256-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f84d9aaaebfc8ef4f1089e814b46d1987c7f8c2ff5d65869ea3a62bdc098316e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.256-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0abf68ea97c3a59949852c096dc810abc075844d72285e15f909fd943a277879"
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
