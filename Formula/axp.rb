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
  version "0.5.765-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.765-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "0a2da29667b5d3bf0a443845a671ad240fb60228bc4f98452d72b6d3be9d914c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.765-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "ca641b681cc44ec1ca4c3bdc661746ea649b736f56153c4c42f6c51a6b22b100"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.765-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "2eaaeaec9c0f8d985f630aaff2094519a57ef1a3842dfc3592b44cc6a14b84b1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.765-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "a685352e78baf60bb922baacdb62192e05568ffb7c3a625b900448ae35901102"
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
