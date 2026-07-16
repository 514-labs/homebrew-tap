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
  version "0.5.239-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.239-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "4f7449de582cc2d333c32ad1d9ed4d3fd664a2114f18556b066227f8d8c64253"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.239-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "5e3960c7b2cc320b56171ac8be013267e195f7d882ec0d7ce6f999ebd548547e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.239-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8d61030fa52b14e1fa941f1f361716c163fc5164da04f774648a082fe7e0c72b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.239-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "572feeb9ce008417a715a4dadf15015475ed9e985007f99590b231556ff3a16f"
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
