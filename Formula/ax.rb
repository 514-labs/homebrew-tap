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
  version "0.5.990-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.990-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "695e344dd5ddbc916d9f12ba676a31f0e69efce0230ef77b616c228559223958"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.990-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "5b19daae1543514a183994ce61939a8fd398e28f4e0acffb3ac3eba145152f0c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.990-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a44f25cc12572c063d97c44230bfe8708d0dc79898e843c88365c1549617c0f2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.990-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e5de0d72278b1c16c6d2a5330c0a84b7c429d9916aefd4933fba3d94f82bf865"
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
