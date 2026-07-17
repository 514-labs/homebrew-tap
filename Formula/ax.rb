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
  version "0.5.255-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.255-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "a71fea2c90a582664d59c01a17e27cf0c5835e149ff342001de189218c5ce11d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.255-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "38f87b51645b9f861ee8889aa9391da51415a14f0dc93c786ebfe908def5a741"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.255-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "414aab154a5f98e7cb551e399e2fd899258288097636c5851f9feb1dd66a848a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.255-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a6bb3a8d9cdf3ba20a08eb0bfe3063bf60a8fd985a1ca8f09c9e40def906b31c"
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
