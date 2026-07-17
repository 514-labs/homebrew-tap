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
  version "0.5.257-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.257-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "e1e853a266b2b81c39470048b7923608f15d932c8034441ecbcc01407c779f91"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.257-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "9b84ac1c1610dd74585353aca38eb6df61793fea9c1905fce9cc59521a2b6301"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.257-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "45bc37b2093066652771e3d57282cef6c5631174359e1a4cbacfd5ca0cb02add"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.257-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "7f9d5ce3c22cf61e25e355fba1d9fbe8fcfdd24c109b740ec1abaa3d06555680"
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
