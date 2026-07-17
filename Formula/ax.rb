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
  version "0.5.265-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.265-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "a197d8a7c1fa0aa620091e955d77d2c315d5eb4fb9afc8b437aba2ffa77a3bf4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.265-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "21b3686ba69ff789d6facabf9f53c7b3304b09182de958425a09c855b2cc2c86"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.265-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "32a68ffc6e6ef37c8e396caddfde1876c69f49c408ab577174f176e0c0c641bb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.265-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f5e9955faf07e68425fcdda807cee1b08aeb367c0696c931ff1bcfd9bf7b71b9"
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
