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
  version "0.5.557-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.557-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "63e43c61e2cd107cde7ba7ce46b564d3854d3dfeee1b70cc0a81182d0444499a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.557-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "a9f0701c5a9f9f643a4840b66b959d4f40abd89284cc4a601ef5c35d6c48a7e2"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.557-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "0e359f12308a036178dedf740a0f723d5de8ce7971d49afb9eda080f8ebb0192"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.557-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "3d15bf35b242f13ee6f558666884cb9cf343846e3dd51975eead0be35aa22724"
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
