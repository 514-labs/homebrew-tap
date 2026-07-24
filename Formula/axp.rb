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
  version "0.5.404-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.404-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "e65def210d4d49af0901554982b92d4921962c09886747010c6d5cf7050ae848"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.404-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "4aaa4295f992e23faf0a599a53edcbec9e251ea194b9670c98a671922e40c1d1"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.404-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "8c6496150285178cd05e55a71b515014948270f5ed38a960996d98db5337ab24"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.404-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "fdd448eb820f16d60e38b79da29b9d63ba62f46d3fe05b3e515b96c3c39175c1"
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

      Create and run an experiment:
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
