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
  version "0.5.272-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.272-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "3210a25fe984402d23e9685e893eb526911ff7e3c59281ed0dc32d43c28805c2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.272-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "a33cc904adef1cd4794f1438355b9a9d1f0e83be94f8c3e1ca7161dc8584094a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.272-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "11996a0204b8fcc49dea6ab410abc7973fff83f661d76f6c65aff1d43ab8572e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.272-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "e5c175457d597064156da1fac37e610eed6ab9aebbdaedd6e3e9f326e095c47e"
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
