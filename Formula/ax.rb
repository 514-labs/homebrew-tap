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
  version "0.5.262-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.262-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "c35478108283687ff976e5808c2ccf49ba3266e64599eee5d50ec1884d4b201c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.262-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "be2878eb2fb1f71204d4b4ded1155e8c2a685f6fe8a2ba14c7f6c5aa3e206efa"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.262-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4c6f1f8bdd974f49c45c254da0557a9238e38169224d2605f1c5fa244b6d15ad"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.262-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "085d216c862ac11d11c557c7cd7efd51437db1dda946b620540791cdae8b041b"
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
