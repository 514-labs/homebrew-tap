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
  version "0.5.777-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.777-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "b0194a0eacca2d8ef17d44c092c006447a02bd82e2172567c010bf0c6c133bef"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.777-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "3cd2623b7880a49b0a593afad5eff5b809eb070f0fc304d9548747b5a5836817"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.777-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6cf2bc27cb40c56efe05cadf48f78017202a9a4732c939c3e90ad6b61c566339"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.777-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8d269c15564c588006fd47c0918da941d11f8d18034af122e018d3b31aebf7d2"
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
