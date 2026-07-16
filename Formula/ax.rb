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
  version "0.5.237-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.237-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "0c4ba86e73a73b7fb31ce1894d393defdcee97c2730d425f9a88588ade77d3d7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.237-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "e70bd4bde5bd85df7753d27264ca56e9620ea29dae6193351ec8667cc7067862"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.237-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c752c68612a1647d9ff3db01213c29930ef2196ed8d44ab7487b4b1d3d6c9b26"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.237-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "cd5787b17b0fa8e5188dc7a7ea78f1a4008b1642178ea396598d7bf474c96954"
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
