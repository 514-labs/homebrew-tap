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
  version "0.5.886-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.886-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "c377318fd41f16651476fdb9a29bedb9b0c9938f4c296193be98feb5a431a47d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.886-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f9146ba1841d2dad0367f5453de51dd1de148aab9ccb51c38cb508a246dee95f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.886-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5f5041dfcf0bd07232a897d0b1fdfa0c014f300e8e4c56d9136a7e117794f44e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.886-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0cd4466a745472451e0bd3d9481014458813aacf76b06514e7672becbb0883f6"
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
