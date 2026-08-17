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
  version "0.5.809-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.809-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "3fe03f0da029652fbda46fb554955b5dffe56eb5faf136b90bd0674bec7462d8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.809-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "2a38a3d403116904da594cd0bad47f0dab0e4e32a4d3e285682f17ae8a4df6e3"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.809-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "017ebf2b73168029fe5704eec7600211a76b627fdf801934e69edf1f3b20aa56"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.809-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f2144e8be025bbdac1093d0739ec4e6b672649a3ff298bed9eb11c6bf88c585d"
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
