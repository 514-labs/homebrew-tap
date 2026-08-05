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
  version "0.5.659-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.659-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "c8926a0a1f87739d4f6d995c0520b4ec5f7d7dfba7ac6d25341ed9336d4820e7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.659-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "9e78af2cde8e7665384b463ec940a47eceafcf6e3253ad1433cdc1ddb35ea16f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.659-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "dfed643e4452ec1da99bc66ec6ba6283964d5b95288be2583815b3b01b74a1a6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.659-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4be82ff30042f21e3de6ba6e608fd2e9306f336ae357c70c5506fa29ad7ba329"
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
