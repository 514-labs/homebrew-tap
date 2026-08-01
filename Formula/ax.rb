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
  version "0.5.575-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.575-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "16ebbd1c1a28558f96e90b131b57c05a508ecfc7a776070133e194ed21d5f0bf"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.575-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "504693503000958851a11cf35d5d62ab6321ca38e8deade22331b7275e2f3296"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.575-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "766326b5b1afd4f4163c5bc80856aac61459d6a77edcaa3be7c85f005cb800bb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.575-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "820cde9d8c2539ce5d3c5556fb66de9ca588e7f43349a1482782299bb36a3422"
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
