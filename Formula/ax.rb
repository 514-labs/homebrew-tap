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
  version "0.5.563-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.563-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "6f0dd3d7a1c2b72a8bc62fee9ca73287c3aeb8cdabff0cd8eec263e296bab5cf"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.563-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "edea9621f93a9f18412fbc4416dedd49978b7e81e94fb2ad61da305c6f65ae0b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.563-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "7698cf66086ece7e3bf2d3de67e4a799f087cc09330cdbe78d079adb1343d4f9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.563-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a16f569c028fb3c0d37cb55592b0d71270984e5ccef00eb0abc7429545d6b14f"
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
