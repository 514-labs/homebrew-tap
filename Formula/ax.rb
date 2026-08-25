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
  version "0.5.871-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.871-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "77305d3f834e7fee350b4097030ffb0567c23ca90c0ec88c47335e941855559a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.871-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "659bfc42f9b05c8bf4cbdecaecdedd6db0a06420fbc08a0a9466a1e1f79fcc1d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.871-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a496df7f213cdbc5c07426fcd557fedc326b9eb7d4ac3dcf961b47e4f9bbfce9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.871-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "81d9606bcf8d6ef5ed7f3118c0e2001d8a56a53985d19bf855a7fc3873eefd22"
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
