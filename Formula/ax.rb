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
  version "0.5.863-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.863-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "c33233a91d1b9328f7880daeae1f4d834d77545de377b1c6bebca010c580aa4b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.863-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "720ee3cdef2d1ce20850f785c1e68a33eacc9cacd3e53d8d14e816de0a7a4162"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.863-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "29f02b62116ab262aefec2c9733657c9500a7a4e6bd324fac66c1cb1d5b3a6c7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.863-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c8c604ffe396ec4fada5bd482e1a0162b96a8dcc205fbac50f22ba471c2943d8"
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
