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
  version "0.5.244-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.244-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "72b40bb635a243ced27c576a12944463b79ea0348825119f0eacea8de2bed248"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.244-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "f2b9980c92e48da9b3640382fcfdd6104f94ac7d6b5542ff22afdedc548f506b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.244-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "bcc23cc1b823003e0369b8d21e96f999edffd37ac3f3d2f7672aea9a2b6a1934"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.244-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b85806a5af702aadf84cdcbcf1766cac180d57ca99e7392a1a55bf052abeab62"
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
