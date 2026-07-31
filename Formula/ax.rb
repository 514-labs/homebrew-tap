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
  version "0.5.569-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.569-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "9457ca01615fd49f5d90a0302a2432b59549274508a53ab570f3dab7f4c69bc0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.569-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "286999a18454ab499c10946524f418174c8aedd6b6dab40957c5a3eac7455f55"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.569-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d41974a94e961a737fd06ccb336ee2e3bc02adaec832f15bf42682bf15b17aa8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.569-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "088b2bcd9b5c5be0bd20f20926849804333be8edd67c696e7cd446f4d500c4a4"
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
