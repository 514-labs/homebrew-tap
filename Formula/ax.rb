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
  version "0.5.583-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.583-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "5746942cc792a1be535b4c304aa165082093bb9fedff579be7fcf1dc30146947"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.583-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a7c232b185bfde7766646167ce7f726f38f97a4c4bd55d57aa93f87f1e0522a5"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.583-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "75f11e18deea582cbf44b4ecfc3ee30f97114e5c55f16475a653c072fe53d371"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.583-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6c3f20faa66a10b81266c950ca2f3543aeff4e819639ee1f51115deef4e28613"
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
