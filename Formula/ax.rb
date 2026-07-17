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
  version "0.5.267-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.267-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "5bda6581ce0e469c1a0841b364a0201199257b4354ff395bebcc8d5ea9ad8c6e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.267-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "59141f34516c9fc285b2daf6abc001811103b063238655ebd381f187dcd94b72"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.267-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5274beaf12a45280a96e1a0ef18cc3fe2d15c2e726ba4fcda2de3f02ba68e754"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.267-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "91a9fa9ad926318894b0e1bd3e2f0b4bfe2f9ef680ee6c2510c976af7b22f7ce"
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
