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
  version "0.5.250-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.250-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "23bf85bce41a2a40a7cdfbb5c78426561335fe62d40a08738ef2ba0d4bdf51f5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.250-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "370e82f2dba474479c7b945c03bf558b6fb54251a691b36ffd2764b9b8fffa17"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.250-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "71c2714b0ced14272ad774f7641f9d9445c2bcd55cd1af8bbec25036f740ca9f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.250-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "830b618aa13f3fcc5bd2285d3c6c5926658ad933984cc5b6511ef3ab2b455a42"
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
