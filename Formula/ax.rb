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
  version "0.5.621-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.621-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "8bd667bb27946e6b9549cb84d02d7db4a71725875fe12cc2cd0f6531fd7702dd"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.621-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "54d1a1f14212c49e3cf72b5f0b546b15161e00684411f006ad3163b998e12888"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.621-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "30185160fb274e11bacb5da8e793728458b52071c41d7f4ad9465f9c2de25a3d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.621-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6298906ce42cccc2b509ec080e6355d3845ba57d6973c1378ab1372201a4d67b"
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
