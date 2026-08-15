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
  version "0.5.802-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.802-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "68cf26033599a345d2a1d3f7a4550db807ade896a83e426bf1f5875f934bbf9b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.802-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "1705d4fdc8de36631543ae3cebcf7fc3e8ef8658f1f0c2a32a2973472d2346f8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.802-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "6865836958aff6c7d1940451a6640790e2e31cc06dea00354e36f3d046c4bc9a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.802-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "9d5daf482ea2ab344154d58433df226f2589d44c1f88a6d6efdb94cc91365911"
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
