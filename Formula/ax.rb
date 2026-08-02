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
  version "0.5.593-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.593-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "000ee82dcee7743d31dc2d23598d2abd1cddd392235d91b1c7420416b86c2306"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.593-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "31d98c84ce161c8d05c599eb3b12549298e379461a34092d070cfb8c1e2b7497"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.593-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "29b526f9d526b2da32184392f51967f66426a1468e0a529e3dc77b21aa94832e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.593-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b141c25a7ff71108ff791663a0ae3d946d91285a58454a87de264b7735b42d97"
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
