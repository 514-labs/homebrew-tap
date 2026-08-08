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
  version "0.5.714-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.714-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "61efa50d9dfec18b0192b7046278d615a633f050bf7208b5de88ea28efef523b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.714-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "18f19076dfa0ae18d8931e35fab695655e956a8795293875383e459c8a68bec2"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.714-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "51cf650b4c441c2f1629a0c01aa1a4fafc889be9b3b45b7e6be6fcbd322eb39e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.714-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "61489c73646d84aa7ef9cdd282db780a695da9b9c67a30242bba19938355805a"
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
