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
  version "0.5.259-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.259-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "86b33f9af174dcb9d3d9d0036cd8e32d3430a83262e3bf2fc152c03beb22a5c7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.259-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "b126a9f7643fad720777989b73526bae9f157c33916a9745c49fc6bb990f8752"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.259-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "fb27432039aa97e756f8cdaa0c833030cb94796ca44531984bfddf1a2103a912"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.259-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "0961d38544e6a0d9a29a685bbecb4abc0a60665e4637e6103e172b52576d4a9e"
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
