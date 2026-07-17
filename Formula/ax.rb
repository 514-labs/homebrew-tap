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
  version "0.5.254-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.254-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "d5b0f1fe70b17fcfd8fe871a441e17e76336e350b023f2904ee86722e7977779"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.254-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "fe644893c8c6dda98938611fc09f8e38957ed3672ac25601678a40922c160230"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.254-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d3bfab394025c26bee9f4b627df0d0a1d1062295dc676c28aa341f02904c4861"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.254-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "84c1adbc75a65680ea32072562fa228a0dfb6c79ce72f387c79e21ca29b3824f"
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
