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
  version "0.5.899-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.899-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "82155aeb44c7df8ad555adbe1a6298c952dc85c72a22da39d0d216208a95fb82"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.899-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "d8c1617ff06a4843839375788a3b9f9f9f9ee0291b989f1490ee100c51b2f640"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.899-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "91f6ce18c4673882f6b5e927ed568d2ef50443e4c2b775648147e5c0e8b1ecea"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.899-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "561fec0ab1de7b165dcc32aaf62e8939725f5f3fe1591d634b3d78246bb7f92f"
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
