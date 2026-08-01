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
  version "0.5.585-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.585-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "75aed52c064bc81e02a384d7c8c4483286e88344e07b7d0c5817d3f8b2ca6cdb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.585-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a240b9760018c11f39362af576dd332e873a8eff96b33a4471233cea3a52a761"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.585-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0e42e71ca0c40be04459bcbb200a55e3bc3e026b0eca3ce159be43920bab4d0f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.585-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "37d41e34a1256f03fa9be8bd777327f916b7c4d2d6043b70015977589cee4cf7"
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
