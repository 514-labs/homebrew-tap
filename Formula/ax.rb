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
  version "0.5.747-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.747-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "149d2474de2fad4bf8b00f8951c1c8cd52598c39f9b0e17ebabfd7da8abe945a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.747-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "b8f03416ab20a3224ab7ce1d9a41ea94aca644dc1b1e5f31aa62b1bd7388fdc9"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.747-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0e0e0e020152bdae6f4858000cd7d84bc0288e90942fc8b77839fd0813b9eb16"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.747-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c54b187ce2dc784bbd2479c64db872500a4382b34bade2d26c1b3f564c8d894b"
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
