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
  version "0.5.273-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.273-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "08c7daaf21cc296614e3d647f341f1e9bd4659c5213e23a2daec89629aa293bf"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.273-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "87713ed6aa333d39e1617584ff7940f28dbf9c5c89a2b5559c8ab52fbf51fcc6"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.273-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "99ae235b3535a6b7dd45edea75d0d709fbc1d6dfc2537650f062c4529b786623"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.273-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ad6c6bcc4f9f3419077fd0a3ab4f66dc98e00b894e6d352234856dc60f77ba2e"
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
