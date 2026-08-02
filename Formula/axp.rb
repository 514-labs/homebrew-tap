# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `axp` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
#
# ENG-3612 deprecation window: `axp` is the old name for the `ax` CLI. This
# installs a byte-identical binary that prints a deprecation warning on every
# invocation; switch to `brew install 514-labs/tap/ax`.
class Axp < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.597-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.597-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "d389bb82dbf063ce2764530d415a69202c50ac540bd73bd4294148b7c96853eb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.597-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "71db7c1f77014fc3bf059e542b335d85d8ad80bd09f81aab589f3ca7ad6a8949"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.597-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ea7d3654b3b4e51866fd183f89be7e6dbe65d9aabd61983399b0e77d8c9af5b6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.597-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "18e98e527a46e9955e3f94007de3c59488d3d5bc52ef74bdb24bfa4fd8cb00de"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch relocatable archive
    # (`axp.tar.gz` = `axp` + libduckdb sidecar). Install the
    # members into libexec so they stay adjacent for $ORIGIN / @loader_path,
    # then symlink the executable onto PATH.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"axp"
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
    # Keep the smoke test hermetic — `axp --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    # Clear loader path vars so the test exercises the archive's rpath
    # ($ORIGIN / @loader_path) rather than a host LD_LIBRARY_PATH.
    ENV.delete("LD_LIBRARY_PATH")
    ENV.delete("DYLD_LIBRARY_PATH")
    ENV.delete("DYLD_FALLBACK_LIBRARY_PATH")
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/axp --version")
  end
end
