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
  version "0.5.565-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.565-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "89ccba076a44c6d3b3637a47d727bc0af47553b084a196d985fa61a949df8da1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.565-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "1cff69268bdcd0ad3062f049a2c47e362e21615946b6a3c4f4d7cd8cbcaf96a4"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.565-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "01c6e44641c6e04c611c9b5f97466430f4dc7838fa63d0ba975239e5c6aa030d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.565-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c86047f95d2e8ff3a0c60107550a2debb90dd038f8e0829527712b3273fc612a"
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
