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
  version "0.5.707-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.707-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "0d3907daf3e9ab50cfce0810069d0f37f1e6f8faf4ae40ff0c5a94026538d87b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.707-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "ac5d2dabea59d90769f9ec030b13cd105b6cc0717e7d3387da332c8eb11db34d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.707-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f3d205fdd9edbf6f54686d5d3e1ac2e15cf10c43f1016a39a8a8437fd444f76a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.707-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "51b2c127b94def3eb3c487c29f640f10f83865b1294bcb01a471ee6389a598cf"
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
