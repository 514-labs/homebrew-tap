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
  version "0.5.894-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.894-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "f92d39403e63b8a1cdaf7184ea07fe1dc7ccec854a77062539571e7ed357107f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.894-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "8c9d47a265ee5d58a810ab0e6fcce42847bb4cf8357ebe192adb55509d41bad4"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.894-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "603569c0ecff3cd0d8db6ba44051447e40f8ab23c703fa291d90e0f9bd98246b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.894-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0253cffa9b03c06945f1371d38cb9d7567f114da25683c41c6c64f8d79979197"
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
