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
  version "0.5.265-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.265-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "084041cfbf5f2e484b285638c7afe63d7fc6334df21fe4bf832caa6fde7af029"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.265-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "a51d10155513b5cb35d8c74cb9da3c007c6c4ed168a431a555b1b97f460264cb"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.265-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "0539c59ad72477bfd69652c1c348069f4cc15d04abbf0f0423fe6574676435d0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.265-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "5dcd33be2e99549a1a39f2c3490aa03e5335f809218d143d8b9cbcb50a4e13d7"
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
