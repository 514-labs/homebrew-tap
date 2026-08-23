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
  version "0.5.849-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.849-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "0c6eba99f496cf5c522620a78286ca15c0f6917624861ab651c82afc728f3b14"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.849-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "2348aba06b97e3341209c9450c3b9e5c28a94327cb9ef48c161fc8ea1f278463"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.849-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "aaaac7e0f3416258911c34fb569643ed06acd2f9bf5d142919aeff6cad6410d3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.849-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "56b7b4c1d6f556f231e6d36900224b594be042be46b6633d171c2023cba6c53b"
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
