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
  version "0.5.866-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.866-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "5b8a089bd9f75a900cb85ad78e086a59948e3a382fd1ab7fab5e2e5f6fe7f7db"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.866-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "24f343df9cc03e61fb1b16372e777c1da3cf3bb9bfe130954cb2aa589068a331"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.866-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "03acd06676e8debe3f301369ed3e514cac7a087932cf635a907b12aaf50c3eef"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.866-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1c31e7cd0c92b3f9d5c29e69adb86f0b8b47438898087d6eafd9312116f6da6f"
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
