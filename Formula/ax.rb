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
  version "0.5.568-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.568-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "48f169857d1cb41f91e3c35afc326966d0715218af5c78c18662fe7e96c70e8a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.568-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "828aaddd6537e8b3a62cf2152d961391ef909c3ce58b739c9ab4fd2a6cdc77fb"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.568-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5d1b6b1f3f029d3f9a48b0f52a0ef2cc918dd7460679ed298821ad1e81a1012f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.568-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6ba4afcce71bc26be975fcdcf85482ac6268b300464e2d45e6d4e1996fad3eca"
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
