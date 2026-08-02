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
  version "0.5.597-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.597-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "2f5d6e6ae4a0f2f817a2e0ce123982d1f56eed9053dc49ea1e3de5c7ecb4585d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.597-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "47099c898467d3b2e190cf5914578b7ed65ac19d84408be37913556b3507a3e6"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.597-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5f8df28cb9dc286b12d3951e459c5c4f38ebd302433bf72d591847e7dcce6f03"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.597-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "032683a09a21291b5ead56c1920f5530161c2ae2baf898a2e0ede56a5589500e"
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

      Next: walk your first experiment with `ax learn quickstart`

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
