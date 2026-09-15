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
  version "0.5.1043-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1043-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "7dbb7a77b2fbc4d1fc574a5f6b14fd54b3084be726807d806328cc6409ff695f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1043-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "9a5fa97a728bf8d854f4689d5739319b57a12fb30735380414b6def0b13aa30b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1043-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "99f8ca3ae4e27bdc33d25f597e25310336e1c69e0dd0a3b1462aaad6e93878f4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1043-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "78a40f21d72cbcf0d3b8ccba725c2d5b78c85e76cd504029e0aac8e9be2e1b8e"
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
