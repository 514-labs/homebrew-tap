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
  version "0.5.848-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.848-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "4697e202b013fdc6cf9c18c362a7f3e993983ae67718d4c420f546a809cb8176"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.848-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "39ba8b8557c10b5a50ce3e36eee249027701d42c537433c00a2f783dc2711ea6"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.848-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "784d36b4297e51301a16772c9ff159d7846f5b1f2bc6f9fa3539e775db86882d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.848-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c6b7495978ff376ca341c84e85d09d22e0d06c4e832d0cc34371909686dbce0a"
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
