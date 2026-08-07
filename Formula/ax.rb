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
  version "0.5.704-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.704-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "246a54d4249e4219c7a0f8a6cee3f0ffcccc3e3ee1c8333a6ab04dc032f3581c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.704-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "5a258bd6c99c3cb412841784d5a3729a3d0fa07f6bed1ee08f6552c7abfc691d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.704-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "fb88a1fe667f2d8d822814bdedf50598e1fa203631bb4ec9e0d3d89fd71ca654"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.704-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e4b87be2ed8448516fd47a50e1e5f5ab8ee64404dbe202f2f09eaaad88e1a3f2"
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
