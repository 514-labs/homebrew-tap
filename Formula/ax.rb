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
  version "0.5.271-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.271-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "2bd05cf941e951ac2768f4236316e54b6088e80d6ecd65414df3cdcb40a2ed15"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.271-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "89f3a5391df551ead3702eb8532b0aab2a4c683486e8324b70c54ca67e7f1075"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.271-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ff68fa83401cd2ab02828f4f4c79703a5637997e65b7cd1cbe9e0b1de3d44214"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.271-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9b86351c5d431166d4a161a3db46dcb71842de9f4d7a3c86658e017e9227b5b5"
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
