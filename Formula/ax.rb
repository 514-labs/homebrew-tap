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
  version "0.5.925-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.925-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "f88c7ffaddfbdd6e626952dcfae7104f51f5d59d975c0c8119af01ee472c2e5e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.925-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f938011150848374bf8834bde4a31775f6c2428965eb08adb8500aa406eb3fa5"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.925-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5ddd1795d51858a3349365426b21b5e1744aaf7408de7c2841ba4f4d966ca916"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.925-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "32bf7e8390b9c787bc9b57e5693f3efa14789e5639fe0371467f6e1ea96736ce"
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
