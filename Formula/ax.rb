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
  version "0.5.1323-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1323-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "0a3cb25d310b62d28e8d47f3f25e113bf79d93be9a2584dde70bc5de04321f31"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1323-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "57d034db0936f2ac07dbd1f2f508d577a9a059260522e021e8b917d98f9c6154"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1323-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1c76b25a7337ca6cb4f0ca9ce4d42d9d7023fc83985a75fd6ff664146adb3296"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1323-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e2e38f55820d6043053585ad25c990ae0a8d543f8d76aa92b6c15e7efba3a24c"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch archive
    # (`ax.tar.gz`), whose only member is the `ax` executable.
    bin.install "ax"
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
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/ax --version")
  end
end
