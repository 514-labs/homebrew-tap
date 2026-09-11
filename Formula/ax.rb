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
  version "0.5.1036-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1036-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "36c750e524f6d2c4cbbad8221280dd4b292645e90341d3c58857f9b71b9f254c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1036-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "d3a999314d15a96fbef0f9a2cd35911cdb98f1f7401082559af77d4dedf68f2e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1036-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "80e7bbe0738082dd4116cf6717b315cd8aba3c76d17e600266c0be0d81646b7a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1036-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "7388fdf8423202f778cad0460cc00a88ca1d1491561bd905dcd468c51b329a77"
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
