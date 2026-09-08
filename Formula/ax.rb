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
  version "0.5.972-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.972-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "1482665669d738791222ffa0cf52dbbeedcc2b7af2dbdddbc85cd3fa7c777617"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.972-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "e62fdb40f52a1a7fba13e1444f1a6d751dc5e2822a77ebd0166b6a9cc8fcc9a1"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.972-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8fa0cd3dbf75ad1fdab07b793a1aa42b058c5d3d218ba7bf6acf4efaa17ce859"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.972-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8953c864ce641fae4d5f88e7552e8937af2f1de2c987870c600d71a994160b0c"
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
      Sign in:
          https://app.514.ax/sign-in
          ax auth login --token <token>
      Then get oriented:
          ax auth status

      Next: create your first experiment
          ax experiment create my-first-experiment --template cli-install   # see --help for the required flags

      Learn how to use ax: `ax learn`
      Already have experiments? `ax experiment list`
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
