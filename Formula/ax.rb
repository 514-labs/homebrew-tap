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
  version "0.5.1057-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1057-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "b580eae963e47576880caaa1d4a384df2e80cf411cdb6179fc4d43d745d7d78a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1057-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "8ab8a1bef67cf725b0a211b7057634194ad78cccdc106c80ca7c5e25233009b6"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1057-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9c9be9f8c2e1c8bb9a3985e0865a432f7af1cd8c4b1a5a4d3ab48f561fc796dc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1057-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e6b679869499382aaf4e2c1310e34a14db7b229c06305f8648da1c1f9de4829a"
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
