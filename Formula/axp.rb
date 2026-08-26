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
  version "0.5.877-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.877-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "2d624db78128d75d52f850aa8a94830f045d646e504f605f5767a9f99bfcb40c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.877-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "c8eb8e209011df88f2fc1e90a62c1e677542b1969eca92c9de25c7c52d61f034"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.877-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "d1fecbdd72426e87c6b74440487d2c96904085bcedc9ca0fecfb5f6491a8ced2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.877-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "0fb7b562a03e190e9582453655c47e10502d9bf14dabfa91374428d3b355c656"
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

      Next: create your first experiment
          ax experiment create my-first-experiment --template cli-install   # see --help for the required flags

      Learn how to use ax: `ax learn`
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
