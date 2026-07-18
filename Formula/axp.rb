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
  version "0.5.273-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.273-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "335e59727cade2c99f1460453b1b80643b4e6d36b34273fd088ce9bd1360302d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.273-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "a5510eb005d0c3421dc633e54d984b52b03d6afafd7e3ea12f149fd9a2df3650"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.273-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "3148d441742be13e045710bb3f4f3ae12cab6e99574d837d10361526347b9875"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.273-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "c03ac90196daa2c12d29bd83fc22a70487f79a8e23eaf4977b556792d5487109"
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
