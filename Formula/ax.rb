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
  version "0.5.991-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.991-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "8c1f7610dec3eff7f39410be27d64df8623e09ad9da621b13d4f2e3849c01207"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.991-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "50e5013541129b8929ecf06d39b1b7259b29b2f71c3b2f10b7e8dfc7c6cf5e66"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.991-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a68bd8e54041dd8c81f31ffe440b10e28ce70be20b41dd00031e596f3dc3543f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.991-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a40ab0df05f989822cd90b59527420a896f5127d995376d3504ae3e3af4d0425"
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
