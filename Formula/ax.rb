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
  version "0.5.892-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.892-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "21f7d0dcd08cce189e2352db8ef488365e9dd322c3800edc81a3671dca45749d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.892-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "45894b6b9602f402b6ab1e3b2fbb9769e98a616f722e42d3d4d8fb21bab4d2f2"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.892-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b914318931e5f3b206fcf40dc955476b1b09afe2c8185c384c46b2b0805e5976"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.892-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "69c8c06034abb37ad422072b6a5b05df96505d3c9a32b3646af711fbb6e0de52"
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
