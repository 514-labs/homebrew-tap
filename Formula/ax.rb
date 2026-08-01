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
  version "0.5.576-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.576-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "623c5221363f651d0d8a7dc7478aa57ccee8028232d1e599427f7b73a5a26159"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.576-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "53277cf447b0a186d69043f2de33442f6668618141f68d1632f4bdfe1856ba95"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.576-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9e5111ffa1bce9073fdc574fca1cdb9a6f6f939c66cc59aeff785320846e0bd8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.576-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5a5398e2a7213b5155571202513e865711739b1e92e1c04261cac718342a3672"
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
