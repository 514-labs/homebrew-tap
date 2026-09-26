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
  version "0.5.1151-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1151-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "5a449b6449080e7285697dd7d8582dfc003d42c694ee52df758d676b68abf751"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1151-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "17aad1138851bf9cb1dd4d26f3f03f0be506e846c382e474493fc3b7c4b277a3"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1151-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2488d86429447d978c0a81bbecf73aadd7ffe4ad6dad2f507c01a9c2dd70e9d4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1151-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b9e797ae4b09758a5aeb3963b03c7a276897869a0f52dfc26b4f706a21d5dd27"
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
