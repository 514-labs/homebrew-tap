# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `axp` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
#
# ENG-3612 deprecation window: `axp` is the old name for the `ax` CLI. This
# installs a byte-identical binary that prints a deprecation warning on every
# invocation; switch to `brew install 514-labs/tap/ax`.
class Axp < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.1114-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1114-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "1a6a6a70089c777c574d3025f1cea918fc5ac2c25070f4528173621c7b5431a4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1114-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "3b64399f84fe7b68c0c9ba433082d67b40168b435691584b56d7d478a8a2bbdb"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1114-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "5b9ebe42d477a3d33b39e61255838bd29c036bf9c90ceaaa4f3a73eb0ec03a99"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1114-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "373a4af476dfebd9572e7a9af936d3a29df32d057f9fc3f79d5aa61acd553564"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch relocatable archive
    # (`axp.tar.gz` = `axp` + libduckdb sidecar). Install the
    # members into libexec so they stay adjacent for $ORIGIN / @loader_path,
    # then symlink the executable onto PATH.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"axp"
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
    # Keep the smoke test hermetic — `axp --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    # Clear loader path vars so the test exercises the archive's rpath
    # ($ORIGIN / @loader_path) rather than a host LD_LIBRARY_PATH.
    ENV.delete("LD_LIBRARY_PATH")
    ENV.delete("DYLD_LIBRARY_PATH")
    ENV.delete("DYLD_FALLBACK_LIBRARY_PATH")
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/axp --version")
  end
end
