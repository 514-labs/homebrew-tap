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
  version "0.5.310-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.310-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "7561d9c1d3a6567a232725759d12e768b3439c48d6645e8926c12332b88048ff"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.310-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "599bd7771ce800a55297fa9fda67135f1d97531cb5882bc770eea65193cc414a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.310-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "3b89443c1f5358257be76f56b3ab0371f124748026a276634a8d948379a295d8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.310-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "870c6cb38ec783272efdfd86515b6c7dbd3698f722562e07afb6472fa367bba1"
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

      Create and run your first experiment:
          ax experiment create my-experiment --template cli-install   # your agent writes the YAML from your product description
        → ax experiment validate ./my-experiment.yaml
        → ax experiment run ./my-experiment.yaml                      # smoke: 1 repeat per variant; scale with --repeat 5
        → ax experiment query <exp-id from run output> --metric testPassRate
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
