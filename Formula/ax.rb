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
  version "0.5.835-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.835-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "a3122bb9c8f6ea8a173cb90d93c886f494b371f7fe406454dc59f04fe1aedd9a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.835-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "143b24b392c3faedb5902ddee8e4b71a35e91d9b8552efd18df37b8d7d31918a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.835-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8383ee9e07896074b620f5a9cf43eed9a4211554f30733b520d88c94ccd3a610"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.835-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "673868c52d0f5d2e4c21e9f66112761b428e1d64a9100035e6990598f24b93ff"
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
