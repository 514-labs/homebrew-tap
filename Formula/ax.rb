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
  version "0.5.596-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.596-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "f3931feb2a5221d2cc0d7d6e9c91498ed0b2c8598d592c1c9a706211a69f4d31"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.596-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "453bea6ffde0643d46f20ee104ef41f35adaf5f837669d04c12ffbbd2de1a60d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.596-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "71c6ee4a68a98e8814767b8a5b3e1b7226e0c4666daf12b121c88d3556c1e9c0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.596-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "209cdf4c0ee0d59c2e60141c4d45720f1d5efa53d2e2ebd441d513b7a1eff9da"
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
