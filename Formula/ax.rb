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
  version "0.5.1073-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1073-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "15b06680bee6e58a3e9fb0524946153ab0ec4a68e072bdc2f47150dd634bd74c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1073-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "91c890f27011a2d216625c5238753e9c34fd9f8fc158fe9c0bf1e9c7e8883953"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1073-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4ae0c04d4a2028f783e51ad04364b419f9faea9791a88f591ab298559199c7cf"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1073-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "cfb9a696bd450db8db4567de658c95d99ee95ecd40a8952307566a8481021df7"
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
