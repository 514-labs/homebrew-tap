# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `axp` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
#
# ENG-3612 deprecation window: `axp` is the old name for the `ax` CLI. This
# installs a byte-identical binary that prints a deprecation warning on every
# invocation; switch to `brew install 514-labs/tap/ax`.
class Axp < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.237-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.237-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "ede90dae978e4a4988581b56707ecf0e3e0482b8ca6a6749729330471e94c650"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.237-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "50524c64ec5d08f9844539ecbedf42ecbe8ddd25bcc6a60db6ae40d1b79bc65f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.237-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "c15a7659d2e7d452af2b223130e40f9a6c60c6e179832a39ce1371e7e8c560f7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.237-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ce44b2f08c93b79d37a799190656b971ad21a5b98b0fd391c66eacb008485924"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch relocatable archive
    # (`axp.tar.gz` = `axp` + libduckdb sidecar). Install the
    # members into libexec so they stay adjacent for $ORIGIN / @loader_path,
    # then symlink the executable onto PATH.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"axp"
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
    # Keep the smoke test hermetic — `axp --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    # Clear loader path vars so the test exercises the archive's rpath
    # ($ORIGIN / @loader_path) rather than a host LD_LIBRARY_PATH.
    ENV.delete("LD_LIBRARY_PATH")
    ENV.delete("DYLD_LIBRARY_PATH")
    ENV.delete("DYLD_FALLBACK_LIBRARY_PATH")
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/axp --version")
  end
end
