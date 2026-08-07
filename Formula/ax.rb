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
  version "0.5.705-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.705-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "685bea6a291861cc135161152d7e853c926f315043b9ac3c379a807b5e457e90"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.705-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "5c2a1f5aee79f4a62466d6262c50b639102255f19f615cb8ca721a69fa63689d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.705-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f17785661d173af38a3ff7ee9f5b91a1fe76d14a8a28b0b6166f0b854d418825"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.705-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a01307223e71227d011cb9aa27c7e8020549bc11dd923c614096eb9325623fea"
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

      Next: create your first experiment
          ax experiment create my-first-experiment --template cli-install   # see --help for the required flags

      Learn how to use ax: `ax learn`
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
